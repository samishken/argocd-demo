# ArgoCD

## Overview

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes. It continuously monitors a Git repository containing application manifests and ensures the cluster state matches the desired state declared in Git.

## Why Argo CD

- Git is the single source of truth for application and environment configuration.
- Enables safe, auditable, and reproducible deployments.
- Automates deployment workflows and reduces manual drift between Git and cluster state.

## Problems Argo CD solves

- Eliminates manual kubectl-based deployments and ad-hoc changes.
- Prevents configuration drift by reconciling actual state to desired state.
- Provides visibility and auditability of who changed what and when (via Git history).
- Simplifies multi-cluster and multi-environment delivery patterns.

## Benefits of using Argo CD

- Declarative deployments with automatic reconciliation.
- Easy rollbacks (revert Git commit to roll back).
- Safe promotion workflows between environments (e.g., staging → prod).
- Role-based access control and SSO integration for secure deployments.
- Web UI and CLI for both visual and automated workflows.

## Argo CD architecture (brief)

- Repo server: fetches and reads manifests from Git.
- API server / Controller: compares desired state (Git) with cluster state and performs sync operations.
- Application CRDs: represent an app (source, target cluster/namespace, sync strategy).
- Dex / OIDC (optional): handles authentication for the UI/API.
- Kubernetes clusters: target environments where Argo CD applies manifests.

## Key features: Prune & Auto-Heal

- Prune: when enabled, Argo CD can remove Kubernetes resources that were removed from Git during sync, keeping the cluster clean and matching Git exactly.
- Auto-Heal: Argo CD can automatically detect and remediate drift (for example, if someone manually changes a resource in-cluster) by re-applying the desired Git state.

## Argo Rollouts

Argo Rollouts is an add-on that provides advanced deployment strategies (canary, blue-green, experimental traffic shaping, analysis) for Kubernetes Deployments and ReplicaSets. It integrates with service meshes and ingress controllers to control traffic shifting and metrics-based promotion.

## Deployment strategies: Canary vs Rolling

- Canary updates: progressively shift traffic to a new version while monitoring metrics and analysis. Good for large, stateful, or high-risk workloads where gradual exposure and analysis reduces blast radius.
- Rolling updates: replace pods incrementally (default Kubernetes behavior). Simpler and faster for small, stateless workloads and when you have a small number of pods.

Recommendation: For workloads that are large or have substantial user traffic, Canary updates are generally better because they reduce risk by gradually exposing the new version. For small workloads with few pods, Rolling updates are usually sufficient and simpler to manage.

## Quick tips

- Use Git branching or promotion strategies (PRs → merge to main) to gate production releases.
- Enable health checks and automated analysis when using canary promotion (Argo Rollouts) to avoid promoting broken releases.
- Use `prune` carefully in environments where external resources are managed outside Git—disable prune for those resources or move them under Git management.

---
