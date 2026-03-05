import os
import pandas as pd

def export_fact(df: pd.DataFrame, out_dir: str):
    os.makedirs(out_dir, exist_ok=True)
    parquet_path = os.path.join(out_dir, "fact_orders.parquet")
    csv_path = os.path.join(out_dir, "fact_orders.csv")

    df.to_parquet(parquet_path, index=False)
    df.to_csv(csv_path, index=False)

    return {"parquet": parquet_path, "csv": csv_path}
