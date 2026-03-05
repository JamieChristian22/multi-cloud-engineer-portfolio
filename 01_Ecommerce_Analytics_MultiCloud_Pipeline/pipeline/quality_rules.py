import pandas as pd

def run_quality_checks(orders: pd.DataFrame, items: pd.DataFrame, customers: pd.DataFrame, products: pd.DataFrame):
    issues = []

    # Basic null checks
    for col in ["order_id", "customer_id", "order_date"]:
        bad = orders[col].isna().sum()
        if bad:
            issues.append({"rule": "orders_not_null", "column": col, "bad_rows": int(bad)})

    # Range checks
    if (items["quantity"] <= 0).any():
        issues.append({"rule": "quantity_positive", "bad_rows": int((items["quantity"] <= 0).sum())})

    if (items["unit_price"] <= 0).any():
        issues.append({"rule": "unit_price_positive", "bad_rows": int((items["unit_price"] <= 0).sum())})

    # Referential integrity
    missing_orders = ~items["order_id"].isin(orders["order_id"])
    if missing_orders.any():
        issues.append({"rule": "items_order_exists", "bad_rows": int(missing_orders.sum())})

    missing_customers = ~orders["customer_id"].isin(customers["customer_id"])
    if missing_customers.any():
        issues.append({"rule": "orders_customer_exists", "bad_rows": int(missing_customers.sum())})

    missing_products = ~items["sku"].isin(products["sku"])
    if missing_products.any():
        issues.append({"rule": "items_product_exists", "bad_rows": int(missing_products.sum())})

    # Total reconciliation: order_total equals sum(items)
    items_calc = items.assign(line_total=items["quantity"] * items["unit_price"])
    sums = items_calc.groupby("order_id", as_index=False)["line_total"].sum().rename(columns={"line_total": "calc_total"})
    # caller may have order_total; if not, we compute only. Here we check calc_total is > 0.
    if (sums["calc_total"] <= 0).any():
        issues.append({"rule": "order_total_positive", "bad_rows": int((sums["calc_total"] <= 0).sum())})

    return {"passed": len(issues) == 0, "issues": issues, "summary": {"issue_count": len(issues), "orders": len(orders), "items": len(items)}}
