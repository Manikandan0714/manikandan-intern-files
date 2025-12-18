
---

## AWS Free Tier Safety
This project is designed to avoid unexpected charges:
- Uses **default AWS service metrics** (free)
- Creates **only one CloudWatch alarm** (within free tier)
- Minimal log retention
- No dashboards, NAT gateways, load balancers, or paid services

> Always destroy resources after testing.

---

## Prerequisites
- AWS account (Free Tier)
- AWS CLI configured
- Terraform (latest version)

---

## Usage

### Initialize Terraform
```bash
terraform init
terraform plan
terraform apply
terraform destroy
