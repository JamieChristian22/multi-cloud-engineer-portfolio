# Reviewer guide and asset provenance checklist

**Project:** multi-cloud-engineer-portfolio · [README](README.md) · [License](LICENSE) · [CI runs](https://github.com/JamieChristian22/multi-cloud-engineer-portfolio/actions)

## Five-minute review

1. Read the root README for purpose, limitations, and simulated versus measured results.
2. Open the project paths below to inspect tracked deliverables; their presence alone is not proof of correctness.
3. Review GitHub Actions for actual test outcomes. Queued or failed runs are not passing tests.
4. Verify input datasets, calculation methods, and evidence before citing performance outcomes.

### Project entry points

1. [01-enterprise-web-platform](<01-enterprise-web-platform>)
2. [02-network-infrastructure-platform](<02-network-infrastructure-platform>)
3. [03-storage-and-data-platform](<03-storage-and-data-platform>)
4. [04-monitoring-platform](<04-monitoring-platform>)
5. [05-disaster-recovery-platform](<05-disaster-recovery-platform>)

## Third-party asset and dataset provenance checklist

The following are **sample tracked candidates** for source and reuse-rights checks. Their inclusion does not imply they are external, unlicensed, or unsafe.

| Tracked asset candidate | Verification status |
| --- | --- |
| `01-enterprise-web-platform/architecture/AWS Enterprise Web Platform Architecture.png` | **Not independently verified** — check origin and permissions |
| `02-network-infrastructure-platform/architecture/project-02-gcp-network-infrastructure-architecture.png` | **Not independently verified** — check origin and permissions |
| `02-network-infrastructure-platform/evidence/screenshots/01-aws-enterprise-vpc.png` | **Not independently verified** — check origin and permissions |
| `02-network-infrastructure-platform/evidence/screenshots/02-aws-public-subnet.png` | **Not independently verified** — check origin and permissions |
| `02-network-infrastructure-platform/evidence/screenshots/03-aws-private-subnet.png` | **Not independently verified** — check origin and permissions |
| `02-network-infrastructure-platform/evidence/screenshots/04-aws-internet-gateway.png` | **Not independently verified** — check origin and permissions |
| `02-network-infrastructure-platform/evidence/screenshots/05-aws-public-route-table.png` | **Not independently verified** — check origin and permissions |
| `02-network-infrastructure-platform/evidence/screenshots/06-aws-private-route-table.png` | **Not independently verified** — check origin and permissions |

For each external asset, record original source URL, creator/provider, terms, allowed redistribution and commercial use, and any required notices. For original or synthetic work, note how it was produced and ensure any modeled results are plainly labeled. The MIT repository license does not automatically grant rights to externally owned content.

**Security:** Never include API keys, private/customer data, or identifying screenshots in an evidence file. Treat current-branch scanning and historical secret scanning as separate checks.

This document is **navigation and review guidance**, not a security audit pass, ownership certification, or legal clearance. See [GitHub Actions](https://github.com/JamieChristian22/multi-cloud-engineer-portfolio/actions) for live test results.
