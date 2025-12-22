# 🚀 Ruby on Rails Application on AWS using Terraform

This project provisions a **highly available and scalable Ruby on Rails application** on AWS using **Terraform**.  
It uses **Application Load Balancer, Auto Scaling Group, EC2 Launch Template, RDS PostgreSQL, IAM, and CloudWatch**, all deployed inside the **default VPC** for simplicity.

---

## 🏗️ Architecture Overview

**Flow:**

Internet  
→ Application Load Balancer (ALB)  
→ Auto Scaling Group (EC2 instances running Rails)  
→ Amazon RDS (PostgreSQL)

**Key Characteristics:**
- Highly available (Multi-AZ)
- Auto-scalable based on CPU utilization
- Secure communication using Security Groups
- Managed database using Amazon RDS
- Centralized monitoring and alerts via CloudWatch & SNS

---

## 📦 AWS Services Used

- **EC2** – Application servers
- **Application Load Balancer (ALB)** – Traffic distribution
- **Auto Scaling Group (ASG)** – Automatic scaling
- **RDS (PostgreSQL)** – Managed database
- **IAM** – EC2 role for SSM access
- **CloudWatch** – Metrics & alarms
- **SNS** – Email notifications
- **VPC (Default)** – Networking
- **Security Groups** – Network security

---

## 🌐 Networking Design

- Uses the **default VPC** in `us-east-1`
- Subnets across multiple Availability Zones:
  - `us-east-1a`
  - `us-east-1b`
  - `us-east-1c`
  - `us-east-1d`
  - `us-east-1f`
- Internet-facing ALB
- Database is **not publicly accessible**

> ⚠️ Note: The default VPC is used to simplify setup and focus on application infrastructure.  
> In production, a custom VPC with private subnets and NAT Gateway is recommended.

---

## 🔐 Security Groups

### ALB Security Group
- **Inbound:** HTTP (80) from `0.0.0.0/0`
- **Outbound:** All traffic

### Web Server Security Group
- **Inbound:** Port `3000` from ALB only
- **Outbound:** All traffic

### Database Security Group
- **Inbound:** PostgreSQL `5432` from Web Server SG only
- **Outbound:** Default

---

## 🗄️ Database Configuration

- Engine: **PostgreSQL**
- Instance type: `db.t3.micro`
- Storage: 20 GB
- Public access: ❌ Disabled
- Database name: `myrailsdb`

---

## ⚙️ Auto Scaling Configuration

- **Min size:** 1
- **Max size:** 3
- **Desired capacity:** 1
- **Scaling policy:** Target tracking based on CPU utilization
  - Target CPU: **20%**

---

## 📈 Monitoring & Alerts

### CloudWatch Alarms
- **High CPU Alarm:** CPU > 20%
- **Low CPU Alarm:** CPU < 10%

### Notifications
- Alerts sent via **SNS Email Subscription**

---

## 🔑 IAM & Access

- EC2 instances use an **IAM Role** with:
  - `AmazonSSMManagedInstanceCore`
- Enables secure access via **AWS Systems Manager**
- No SSH keys required

---

## 🧩 Launch Template & User Data

- Uses a **Golden AMI**
- User data script:
  - Updates Rails `database.yml`
  - Injects RDS endpoint dynamically
  - Runs database creation & migration
  - Restarts Rails application

---

## 🧪 Prerequisites

- AWS account
- Terraform ≥ 1.3
- AWS CLI configured
- Valid AMI with Rails app pre-installed

---

## 🚀 How to Deploy

```bash
terraform init
terraform plan
terraform apply
