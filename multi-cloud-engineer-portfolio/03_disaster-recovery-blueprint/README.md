# 🛡 Multi-Cloud Backup & Disaster Recovery Blueprint

This project documents a **multi-cloud DR strategy** where:

- **AWS** hosts the primary production workloads.
- **Azure** hosts a **warm standby** environment for critical services.
- **GCP** stores **cold backups** for long-term retention.

The goal is to demonstrate that you can think beyond “deploying servers” and design an architecture that
**survives regional or provider-level issues**, with clear **RPO/RTO targets** and a **runbook** for real incidents.

---

## 📄 Contents

- `docs/Architecture.md` – overview, narrative, and decision rationale.
- `docs/Architecture.png` – high-level DR architecture diagram.
- `docs/DR_Runbook.md` – failover and failback procedures.
- `docs/RPO_RTO_Matrix.xlsx` – RPO/RTO table with example workloads.
- `docs/Risk_Assessment.md` – known risks, trade-offs, and future improvements.

---

## ✅ Interview Talking Points

- How to design DR across multiple cloud providers.
- Cost vs. resilience trade-offs (warm vs. cold standby).
- How you would test DR and keep the runbook up to date.
