import argparse
import os
from pathlib import Path


def upload_to_aws(file_path: Path, bucket: str, key: str) -> None:
    import boto3  # type: ignore

    s3 = boto3.client("s3")
    s3.upload_file(str(file_path), bucket, key)


def upload_to_azure(file_path: Path, container: str, blob_name: str) -> None:
    from azure.storage.blob import BlobServiceClient  # type: ignore

    conn_str = os.environ.get("AZURE_STORAGE_CONNECTION_STRING")
    if not conn_str:
        raise RuntimeError("AZURE_STORAGE_CONNECTION_STRING not set")

    service_client = BlobServiceClient.from_connection_string(conn_str)
    container_client = service_client.get_container_client(container)
    with open(file_path, "rb") as f:
        container_client.upload_blob(name=blob_name, data=f, overwrite=True)


def upload_to_gcp(file_path: Path, bucket_name: str, blob_name: str) -> None:
    from google.cloud import storage  # type: ignore

    client = storage.Client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(blob_name)
    blob.upload_from_filename(str(file_path))


def upload_to_cloud(provider: str, file_path: Path, bucket_or_container: str, object_key: str) -> None:
    provider = provider.lower()
    if provider == "aws":
        upload_to_aws(file_path, bucket_or_container, object_key)
    elif provider == "azure":
        upload_to_azure(file_path, bucket_or_container, object_key)
    elif provider == "gcp":
        upload_to_gcp(file_path, bucket_or_container, object_key)
    else:
        raise ValueError(f"Unsupported provider: {provider}")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Multi-cloud ETL uploader")
    parser.add_argument("--file", required=True, help="Path to the local CSV file to upload")
    parser.add_argument("--bucket", required=True, help="Bucket / container name to upload into")
    parser.add_argument("--prefix", required=False, default="raw", help="Object prefix / folder path in the bucket")
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    file_path = Path(args.file).resolve()

    if not file_path.exists():
        raise FileNotFoundError(f"File not found: {file_path}")

    provider = os.environ.get("CLOUD_PROVIDER", "aws").lower()
    object_key = f"{args.prefix.rstrip('/')}/{file_path.name}"

    print(
        f"[INFO] Uploading '{file_path}' to provider='{provider}', "
        f"bucket/container='{args.bucket}', key='{object_key}'"
    )

    upload_to_cloud(provider, file_path, args.bucket, object_key)

    print("[INFO] Upload complete.")


if __name__ == "__main__":
    main()
