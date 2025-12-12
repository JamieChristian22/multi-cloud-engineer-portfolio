# 🏞 Multi-Cloud Data Lake & ETL Pipeline (AWS · Azure · GCP)

This project demonstrates a **cloud-portable data lake ingestion pipeline** that can write the same dataset to:

- **AWS:** S3
- **Azure:** ADLS Gen2 / Blob Storage
- **GCP:** Cloud Storage

The pipeline uses a small abstraction layer so that only the **storage client** changes between providers, while
the **business logic** (how files are organized into Landing, Raw, Processed zones) stays the same.

---

## 🎯 Use Case

A data engineering team wants to:

- Onboard CSV files into a data lake.
- Keep a familiar zone pattern: `landing/`, `raw/`, `processed/`.
- Retain flexibility to deploy on different clouds or migrate later.

---

## 🧰 Tech Stack

- Python 3.x
- `boto3`, `azure-storage-blob`, `google-cloud-storage`
- Simple config file or environment variables selecting the target cloud

---

## 🧱 Design Overview

- Input folder: `src/samples/` (or any configured location)
- ETL script: `src/scripts/run_etl.py`
- Output (per cloud):
  - `landing/<dataset>/...`
  - `raw/<dataset>/...`
  - `processed/<dataset>/...`

See `docs/Architecture.md` and `docs/Architecture.png` for a visual view.

---

## 🚀 How to Run

1. Install dependencies (example):

   ```bash
   pip install -r requirements.txt
   ```

2. Set environment variables or use `config/config.yaml` to choose:

   - `cloud_provider`: `aws` | `azure` | `gcp`
   - bucket or container names
   - dataset name

3. Run:

   ```bash
   python src/scripts/run_etl.py --cloud aws --dataset demo_sales
   ```

4. Confirm that objects appear in the target bucket or container under the expected prefixes.

---

## ✅ Interview Talking Points

- How to design **portable** data pipelines.
- Why Landing/Raw/Processed zones are useful.
- Differences between S3, ADLS, and GCS from a data lake perspective.
