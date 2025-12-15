import http from "http";
import os from "os";

const port = process.env.PORT ? Number(process.env.PORT) : 3000;

http.createServer((req, res) => {
  const payload = {
    ok: true,
    service: "pro-services-container-demo",
    cloud: process.env.CLOUD_PROVIDER || "gcp",
    method: req.method,
    path: req.url,
    hostname: os.hostname(),
    timestamp: new Date().toISOString()
  };
  res.writeHead(200, { "Content-Type": "application/json" });
  res.end(JSON.stringify(payload));
}).listen(port, () => console.log(`Listening on :${port}`));
