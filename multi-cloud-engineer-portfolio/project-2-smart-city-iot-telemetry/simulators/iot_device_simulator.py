"""Simple IoT device simulator that sends mock telemetry to Azure IoT Hub."""
import time, json, random
from datetime import datetime

CONNECTION_STRING = "REPLACE_WITH_DEVICE_CONNECTION_STRING"

def main():
    while True:
        payload = {
            "device_id": "rain-gauge-001",
            "sensor_type": "precipitation_mm",
            "value": round(random.uniform(0, 20), 2),
            "timestamp_utc": datetime.utcnow().isoformat() + "Z",
            "zone": "downtown",
        }
        print("Sending:", json.dumps(payload))
        # TODO: send to IoT Hub using Azure SDK
        time.sleep(5)

if __name__ == "__main__":
    main()
