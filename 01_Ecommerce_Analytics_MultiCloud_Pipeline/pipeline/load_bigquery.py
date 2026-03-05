import os
import pandas as pd
from google.cloud import bigquery

def load_to_bigquery(parquet_path: str):
    project_id = os.getenv("BQ_PROJECT_ID")
    dataset = os.getenv("BQ_DATASET", "analytics")
    table = os.getenv("BQ_TABLE", "fact_orders")

    if not project_id:
        raise RuntimeError("BQ_PROJECT_ID is not set.")

    client = bigquery.Client(project=project_id)
    table_id = f"{project_id}.{dataset}.{table}"

    df = pd.read_parquet(parquet_path)

    job_config = bigquery.LoadJobConfig(
        write_disposition="WRITE_TRUNCATE"
    )
    load_job = client.load_table_from_dataframe(df, table_id, job_config=job_config)
    load_job.result()
    return table_id

if __name__ == "__main__":
    parquet = os.path.join(os.path.dirname(__file__), "..", "output", "fact_orders.parquet")
    parquet = os.path.abspath(parquet)
    table_id = load_to_bigquery(parquet)
    print(f"Loaded to BigQuery: {table_id}")
