# Production-Ready Microservices Deployment on AWS EKS

## 2. Overview

**Explain:**

* ***microservices application***
* ***deployed on EKS***
* ***Terraform-managed infrastructure***
* ***CI/CD with GitHub Actions***

## 3. Architecture Diagram

![alt text](image.png)

## 4. Infrastructure Components

**Document:**

### AWS Services Used

* ***EKS***
* ***ECR***
* ***VPC***
* ***Subnets***
* ***NAT Gateway***
* ***Internet Gateway***
* ***CloudWatch***

## 5. Terraform Structure

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

