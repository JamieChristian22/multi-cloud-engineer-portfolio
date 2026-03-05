
# System Design — Multi-Cloud AI Inference Platform

## Problem
Enterprises deploying AI models across clouds need:
- low-latency inference close to users
- cost control (cache + rate limits)
- resiliency (multi-region + multi-cloud)
- clear operational visibility

## Architecture
- **Gateway** routes traffic to regional backends.
- **Cache** stores prompt→response for short TTL and supports rate limit counters.
- Backends are horizontally scalable and can be placed in any cloud.

## Key Decisions
- REST API at gateway for broad compatibility.
- Redis for cache and counters (single dependency, mature ecosystem).
- Deterministic routing by `user_id` to keep hot cache locality.

## Scaling Strategy
- Kubernetes HPA on gateway and backends (CPU + RPS metrics).
- Separate node pools for GPU inference.
- Use CDN + global load balancer + latency-based routing.

## Tradeoffs
- Cache consistency vs speed (TTL-based caching).
- Added operational complexity (multi-cloud) vs resiliency.
- Deterministic routing may cause hotspotting (mitigate with consistent hashing / sharding).

## SLOs
- P95 latency < 300ms for cached responses
- Availability 99.9%+ with active-active
