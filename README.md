# Production-Ready Microservices Deployment on AWS EKS

## Overview

**Explain:**

* ***microservices application***
* ***deployed on EKS***
* ***Terraform-managed infrastructure***
* ***CI/CD with GitHub Actions***

## Architecture Diagram

![alt text](image.png)

## Prerequisites

Before running this project, ensure the following tools are installed:

- Terraform
- AWS CLI
- kubectl
- Docker
- Git

AWS credentials must also be configured locally.

---

## Clone Repository

```bash
git clone <repository-url>
cd damolak
```

---

## Configure AWS Credentials

```bash
aws configure
```

Provide:

- AWS Access Key
- AWS Secret Key
- Region: us-west-2 or region of your choice

---

## Provision Infrastructure

Initialize Terraform:

```bash
terraform init
```

Review execution plan:

```bash
terraform plan
```

Create infrastructure:

```bash
terraform apply -auto-approve
```

This provisions:

- VPC
- Public & Private Subnets
- NAT Gateway
- Internet Gateway
- EKS Cluster
- ECR Repositories

---

## Configure kubectl

After infrastructure creation:

```bash
aws eks update-kubeconfig \
  --region us-west-2 \
  --name damolak-eks
```

Verify cluster connectivity:

```bash
kubectl get nodes
```

---

## Deploy Applications

Apply Kubernetes manifests:

But this is handled already by your CI/CD pipeline

```bash
kubectl apply -f application/app-a/app-a.yaml
kubectl apply -f application/app-b/app-b.yaml
kubectl apply -f application/app-c/app-c.yaml
kubectl apply -f application/app-d/app-d.yaml
```

Verify deployments:

```bash
kubectl get pods
kubectl get svc
```

---

## Access Application

Retrieve the external LoadBalancer URL:

```bash
kubectl get svc app-a
```

Open the EXTERNAL-IP / LoadBalancer DNS in a browser.

Expected response:

```text
App A here -> App B here -> App C here -> App D here -> I am the final service
```

---

## CI/CD Pipeline

The GitHub Actions pipeline automatically performs:

1. Docker image build
2. Basic application testing
3. Push images to Amazon ECR
4. Deploy updated images to Amazon EKS

Pipeline triggers automatically on push to the `main` branch.

---

## Destroy Infrastructure

To remove all infrastructure:

```bash
terraform destroy -auto-approve
```


## Infrastructure Components

**Document:**

### AWS Services Used

* ***EKS***
* ***ECR***
* ***EC2***
* ***VPC***
* ***Subnets***
* ***NAT Gateway***
* ***Internet Gateway***
* ***CloudWatch***

## Terraform Structure

```
.
├── application/             # Source code for microservices (app-a, b, c, d)
├── main.tf                  # Main entry point for Terraform
├── terraform.tf             # Terraform providers and version configuration
├── modules/                 # Reusable infrastructure components
│   ├── vpc/                 # VPC networking
│   ├── subnet/              # Public and Private subnet definitions (IGW, NAT Gateway, Route Tables)
│   ├── security/            # Security Groups and IAM roles
│   ├── ecr/                 # Elastic Container Registry for Docker images
│   ├── eks/                 # Elastic Kubernetes Service cluster config
│   └── ec2/                 # Bastion hosts or additional compute resources
└── README.md                # Project documentation
```

## Kubernetes Deployment

* ***Deployments***
* ***Services***
* ***Internal communication***

## Monitoring & Observability

![alt text](image-2.png)

### Monitoring & Observability

This project includes a fully automated observability stack deployed into the Kubernetes cluster using Prometheus and Grafana.

The monitoring stack is deployed automatically through the CI/CD pipeline using Helm during every deployment workflow execution.

## Observability Components

The following components are deployed into the monitoring namespace:

* ***Prometheus***
* ***Grafana***
* ***Alertmanager***
* ***kube-state-metrics***
* ***Node Exporter***

## These components provide:

* ***Kubernetes cluster monitoring***
* ***Node-level metrics***
* ***Pod and workload visibility***
* ***CPU and memory utilization metrics***
* ***Application health monitoring***
* ***Infrastructure observability***
* ***CI/CD Monitoring Automation***

#### Monitoring deployment is fully integrated into the GitHub Actions CI/CD pipeline.

**During every push to the main branch, the pipeline automatically:**

* ***Configures access to the EKS cluster***
* ***Installs Helm***
* ***Adds the Prometheus Helm repository***
* ***Deploys the kube-prometheus-stack***
* ***Exposes Grafana through an AWS LoadBalancer service***