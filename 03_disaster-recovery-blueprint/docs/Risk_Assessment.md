# ⚠️ Risk Assessment – Multi-Cloud DR Blueprint

This document captures **key risks and trade-offs** in the current DR design.

---

## 1. Complexity

- Multi-cloud DR increases operational complexity.
- Requires staff familiar with more than one provider.

**Mitigation:** good documentation, automation, and regular DR drills.

---

## 2. Data Consistency

- Replication lags can cause data loss if RPO targets are too aggressive.

**Mitigation:** align RPO with realistic replication mechanisms and bandwidth.

---

## 3. Cost

- Maintaining a warm standby environment has ongoing cost.
- Cross-cloud egress charges apply for replication and backup exports.

**Mitigation:** prioritize only the most critical workloads for warm standby; push others to cold backup only.

---

## 4. Test Frequency

- A DR plan that is never tested is unproven.

**Mitigation:** schedule recurring game days where you practice partial or full failover.
