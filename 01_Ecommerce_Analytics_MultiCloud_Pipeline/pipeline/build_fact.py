import pandas as pd

def build_fact_orders(orders: pd.DataFrame, items: pd.DataFrame, customers: pd.DataFrame, products: pd.DataFrame) -> pd.DataFrame:
    items2 = items.copy()
    items2["line_total"] = items2["quantity"] * items2["unit_price"]

    order_totals = items2.groupby("order_id", as_index=False)["line_total"].sum().rename(columns={"line_total":"order_total"})
    fact = orders.merge(order_totals, on="order_id", how="left")

    fact = fact.merge(customers, on="customer_id", how="left")

    # Add product mix metrics
    item_enriched = items2.merge(products, on="sku", how="left")
    # Count distinct SKUs
    sku_count = item_enriched.groupby("order_id", as_index=False)["sku"].nunique().rename(columns={"sku":"distinct_skus"})
    # Most common category by quantity
    cat_qty = item_enriched.groupby(["order_id","category"], as_index=False)["quantity"].sum()
    top_cat = cat_qty.sort_values(["order_id","quantity"], ascending=[True,False]).drop_duplicates("order_id")
    top_cat = top_cat[["order_id","category"]].rename(columns={"category":"top_category"})

    fact = fact.merge(sku_count, on="order_id", how="left").merge(top_cat, on="order_id", how="left")

    # Add calendar features
    fact["order_date"] = pd.to_datetime(fact["order_date"])
    fact["order_year"] = fact["order_date"].dt.year
    fact["order_month"] = fact["order_date"].dt.month
    fact["order_dow"] = fact["order_date"].dt.dayofweek  # 0=Mon

    # Business features
    fact["customer_full_name"] = fact["first_name"] + " " + fact["last_name"]
    fact["customer_location"] = fact["city"] + ", " + fact["state"]

    # Final column order
    cols = [
        "order_id","order_date","order_year","order_month","order_dow",
        "customer_id","customer_full_name","email","customer_location",
        "order_total","distinct_skus","top_category"
    ]
    return fact[cols].sort_values("order_date")
