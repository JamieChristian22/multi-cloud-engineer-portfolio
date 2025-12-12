import csv
import io
import os
from datetime import datetime
from typing import List, Dict

from dotenv import load_dotenv

# Third-party SDKs
import boto3
from azure.storage.blob import BlobServiceClient
from google.cloud import storage


def normalize_header(header: str) -> str:
    return (
        header.strip()
        .replace(" ", "_")
        .replace("-", "_")
        .replace("/", "_")
        .lower()
    )


def load_csv(path: str) -> List[Dict[str, str]]:
    rows: List[Dict[str, str]] = []
    with open(path, "r", newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        fieldnames = [normalize_header(h) for h in reader.fieldnames or []]
        for raw_row in reader:
            row = {normalize_header(k): v for k, v in raw_row.items()}
            row["ingested_at"] = datetime.utcnow().isoformat()
            rows.append(row)
    return rows


def to_csv_string(rows: List[Dict[str, str]]) -> str:
    if not rows:
        return ""
    output = io.StringIO()
    fieldnames = list(rows[0].keys())
    writer = csv.DictWriter(output, fieldnames=fieldnames)
    writer.writeheader()
    for r in rows:
        writer.writerow(r)
    return output.getvalue()


def upload_to_aws(csv_data: str, key: str) -> str:
    bucket = os.environ["AWS_S3_BUCKET"]
    region = os.environ.get("AWS_REGION", "us-east-1")
    s3 = boto3.client("s3", region_name=region)
    s3.put_object(Bucket=bucket, Key=key, Body=csv_data.encode("utf-8"))
    return f"s3://{bucket}/{key}"


def upload_to_azure(csv_data: str, key: str) -> str:
    account_name = os.environ["AZURE_STORAGE_ACCOUNT_NAME"]
    account_key = os.environ["AZURE_STORAGE_ACCOUNT_KEY"]
    container_name = os.environ["AZURE_CONTAINER_NAME"]

    conn_str = (
        f"DefaultEndpointsProtocol=https;"
        f"AccountName={account_name};"
        f"AccountKey={account_key};"
        f"EndpointSuffix=core.windows.net"
    )
    service_client = BlobServiceClient.from_connection_string(conn_str)
    container_client = service_client.get_container_client(container_name)
    blob_client = container_client.get_blob_client(key)
    blob_client.upload_blob(csv_data.encode("utf-8"), overwrite=True)
    return f"https://{account_name}.blob.core.windows.net/{container_name}/{key}"


def upload_to_gcp(csv_data: str, key: str) -> str:
    bucket_name = os.environ["GCP_BUCKET"]
    client = storage.Client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(key)
    blob.upload_from_string(csv_data, content_type="text/csv")
    return f"gs://{bucket_name}/{key}"


def main():
    load_dotenv()

    provider = os.environ.get("TARGET_PROVIDER", "aws").lower()
    input_file = os.environ.get("INPUT_FILE", "./transactions.csv")

    rows = load_csv(input_file)
    csv_data = to_csv_string(rows)

    timestamp = datetime.utcnow().strftime("%Y%m%dT%H%M%SZ")
    key = f"transactions/ingested_at={timestamp}/transactions.csv"

    if provider == "aws":
        uri = upload_to_aws(csv_data, key)
    elif provider == "azure":
        uri = upload_to_azure(csv_data, key)
    elif provider == "gcp":
        uri = upload_to_gcp(csv_data, key)
    else:
        raise ValueError(f"Unsupported TARGET_PROVIDER: {provider}")

    print(f"Uploaded to: {uri}")


if __name__ == "__main__":
    main()
