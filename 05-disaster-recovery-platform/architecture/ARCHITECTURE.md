# Architecture - Disaster Recovery Platform

## Goal

Design and implement cloud backup and recovery foundations that demonstrate business continuity planning across AWS, Azure, and GCP.

## AWS
- AWS Backup vault
- Backup plan with daily schedule
- EC2 backup selection
- Recovery point retention

## Azure
- Recovery Services vault
- VM backup policy
- Protected VM backup item

## GCP
- Persistent disk snapshots
- Snapshot schedule policy
- Instance recreation runbook

## Recovery Objectives

- RPO: 24 hours for lab workloads
- RTO: 2 hours for single VM recovery
- Retention: 7-30 days depending on cloud and cost
