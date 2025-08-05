# Terraform Azure Secure Infrastructure Project

![Terraform](https://img.shields.io/badge/Terraform-Azure-blue?logo=terraform)  
![IaC](https://img.shields.io/badge/IaC-Modular-informational)  
![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)

---

## Overview
This project demonstrates how to design and deploy a **secure, production‑ready Azure environment** using **Terraform** with fully modular architecture.  
The infrastructure emphasizes **security, scalability, and observability** — aligning with **real‑world enterprise best practices**.

The codebase is modular, so the same components can be reused across multiple environments (e.g., Dev, Test, Prod) with minimal configuration changes.

---

## Current Implementation

### Core Components
- **Resource Group & Networking**
  - VNet with segmented subnets (VM, Firewall, Bastion).
  - Custom route tables forcing traffic through Azure Firewall.
  - Private endpoints and DNS zones for secure service access.

- **Compute**
  - Linux Virtual Machine Scale Set (VMSS) behind Azure Load Balancer.
  - SSH key-based authentication managed via Azure Key Vault (passwordless).

- **Security**
  - Azure Firewall with centralized routing.
  - Azure Bastion for secure remote admin access.
  - RBAC-enabled Key Vault for secret storage.

- **Monitoring**
  - Centralized Log Analytics Workspace.
  - Diagnostic settings applied to Firewall, VMSS, and Storage.

- **Storage**
  - Secure Storage Account with private endpoints.
  - HTTPS-only traffic and public access disabled.

- **Automation**
  - Remote Terraform state in Azure Storage.
  - CI/CD pipeline using GitHub Actions with OIDC for Azure authentication.

---

## Planned Enhancements (Next Steps)

- **Azure Policies & Compliance**
  - Enforce no public IPs, mandatory tags, and approved SKUs.

- **Defender for Cloud Integration**
  - Security alerts and posture management for Storage, SQL, and VMs.

- **Backup & Disaster Recovery**
  - Recovery Services Vault for VMSS disk backups.

- **Advanced Networking**
  - Hub-and-Spoke topology with VPN Gateway / ExpressRoute simulation.

- **Scalability**
  - Autoscaling policies for VMSS based on performance metrics.

- **Cost Optimization**
  - Budgets and cost alerts to control Azure spend.

---




