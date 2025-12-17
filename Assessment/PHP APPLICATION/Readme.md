# PHP Application Hosting on AWS (Terraform)

This project provisions a **highly available, scalable, and secure PHP application infrastructure on AWS** using Terraform. The architecture is designed so that EC2 instances can be terminated and replaced automatically by an Auto Scaling Group (ASG) with **minimal downtime**, while traffic is routed through an Application Load Balancer (ALB).

---

## Architecture Overview

**Key Components**

- **VPC**
  - Single VPC with DNS support enabled
  - 2 Public Subnets (for ALB and NAT Gateway)
  - 2 Private Subnets (for EC2 instances)

- **Application Load Balancer**
  - Deployed in public subnets
  - Routes HTTP traffic (port 80) to EC2 instances
  - Health checks configured on `/index.php`

- **Auto Scaling Group**
  - EC2 instances launched in **any private subnet**
  - Automatically replaces unhealthy or terminated instances
  - Integrated with ALB target group

- **EC2 Instances**
  - Ubuntu 22.04 AMI
  - PHP application installed via user data
  - No public IP addresses
  - Accessed using **AWS Systems Manager Session Manager**

- **NAT Gateway**
  - Allows outbound internet access for private EC2 instances
  - Used for package updates and software installation

---

## High Availability & Resilience

- Instances are distributed across multiple Availability Zones
- ALB continuously monitors instance health
- ASG automatically launches new instances when failures occur
- User data ensures PHP application is reinstalled on every launch
- Minimal service disruption during instance replacement

---

## Security Design

### Security Groups
- **ALB Security Group**
  - Allows inbound HTTP (80) from the internet
  - Allows outbound traffic to EC2 instances

- **EC2 Security Group**
  - Allows inbound HTTP (80) only from the ALB
  - Allows all outbound traffic

### Network ACLs
- **Public Subnets**
  - Allow inbound HTTP (80), HTTPS (443), and ephemeral ports
  - Allow all outbound traffic

- **Private Subnets**
  - Allow inbound traffic from within the VPC
  - Allow ephemeral ports for return traffic
  - Allow all outbound traffic via NAT Gateway

---

## Access Management (No SSH)

- EC2 instances **do not use SSH key pairs**
- Access is managed using **AWS Systems Manager Session Manager**
- IAM role attached to instances with `AmazonSSMManagedInstanceCore` policy

---

## Health Checks

- ALB health check path: `/index.php`
- HTTP status code matcher: `200`
- ASG uses ELB health checks with a grace period to allow application startup

---

## Terraform Highlights

- Uses latest Ubuntu 22.04 LTS AMI
- Fully automated infrastructure provisioning
- Modular, reproducible, and idempotent deployment
- Supports easy scaling and recovery

---

## Prerequisites

- Terraform installed
- AWS credentials configured
- An S3 backend (optional, recommended for state management)

---

## Deployment

```bash
terraform init
terraform plan
terraform apply
