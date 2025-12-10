# Operations Runbook – Smart City IoT

- If device goes silent → check IoT Hub connections and credentials.
- If backlog grows → scale streaming units / shards / workers.
- Use DLQs to capture failed messages for replay.
