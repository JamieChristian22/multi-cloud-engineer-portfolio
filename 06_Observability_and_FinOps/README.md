# 06 — Observability + FinOps (Prometheus/Grafana + Unified Cloud Cost)

## Goal
Create an operations view that combines:
1) **Observability** (metrics + dashboards) for Kubernetes workloads  
2) **Cost visibility** across AWS/Azure/GCP with a unified cost model  

Includes a runnable **Streamlit dashboard** that:
- loads sample billing exports from all 3 clouds
- normalizes to a single schema
- outputs KPI cards + monthly trends + top services

---

## Observability Stack (Reference)
- Prometheus (scrape metrics)
- Grafana (dashboards)
- Alertmanager (paging rules)
- Node exporter / kube-state-metrics

See: `observability_stack/`

---

## FinOps Dashboard (Runnable)
See: `finops_dashboard/`

Run:
```bash
cd finops_dashboard
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
streamlit run app.py
```
