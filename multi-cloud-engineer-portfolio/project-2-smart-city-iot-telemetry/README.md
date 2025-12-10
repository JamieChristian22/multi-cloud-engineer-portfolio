# 🌧️ Project 2 – Smart City IoT Telemetry (Multi‑Cloud Streaming)

## Problem

City needs unified monitoring for rain, flood, and environmental sensors, but vendors use different clouds. You design **Azure‑centric ingest** with fan‑out to AWS & GCP.

## Architecture (Summary)

See `diagrams/architecture-smart-city-iot.png`.

- Devices → Azure IoT Hub → Event Hubs / Stream Analytics.
- Warm & cold paths into ADLS / Data Explorer.
- Streamed replicas to AWS Kinesis (→ S3/Timestream) and GCP Pub/Sub (→ BigQuery).
- Dashboards & alerts across clouds.

## Files

- `diagrams/architecture-smart-city-iot.png`
- `infrastructure/terraform/*` – IoT Hub, Kinesis, Pub/Sub, etc.
- `simulators/iot_device_simulator.py`
- `docs/*` – schema, runbook, interview talking points.
