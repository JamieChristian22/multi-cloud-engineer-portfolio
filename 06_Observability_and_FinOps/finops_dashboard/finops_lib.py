import pandas as pd

def load_sources(data_dir: str):
    aws = pd.read_csv(f"{data_dir}/aws_cur_sample.csv")
    az  = pd.read_csv(f"{data_dir}/azure_cost_export_sample.csv")
    gcp = pd.read_csv(f"{data_dir}/gcp_billing_export_sample.csv")
    return aws, az, gcp

def normalize(aws: pd.DataFrame, az: pd.DataFrame, gcp: pd.DataFrame) -> pd.DataFrame:
    df = pd.concat([aws, az, gcp], ignore_index=True)
    df["month"] = pd.to_datetime(df["month"])
    # Standardize service names where useful (example mapping)
    mapping = {
        "Virtual Machines":"Compute",
        "Compute Engine":"Compute",
        "EC2":"Compute",
        "AKS":"Kubernetes",
        "EKS":"Kubernetes",
        "GKE":"Kubernetes",
        "Storage":"Storage",
        "S3":"Storage",
        "Cloud Storage":"Storage",
        "SQL Database":"Database",
        "RDS":"Database",
        "BigQuery":"Analytics",
        "Monitor":"Monitoring",
        "CloudWatch":"Monitoring",
        "Cloud Monitoring":"Monitoring",
    }
    df["service_group"] = df["service"].map(mapping).fillna(df["service"])
    return df

def kpis(df: pd.DataFrame):
    total = df["cost_usd"].sum()
    by_provider = df.groupby("provider", as_index=False)["cost_usd"].sum().sort_values("cost_usd", ascending=False)
    by_group = df.groupby("service_group", as_index=False)["cost_usd"].sum().sort_values("cost_usd", ascending=False)
    monthly = df.groupby("month", as_index=False)["cost_usd"].sum().sort_values("month")
    return total, by_provider, by_group, monthly
