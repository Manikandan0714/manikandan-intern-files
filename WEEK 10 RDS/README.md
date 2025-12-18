# AWS RDS Free Tier (Single-AZ) with Terraform

This project uses Terraform to provision a **MySQL 8.0 RDS database** on AWS. It is configured to be as cost-efficient as possible (targeting the Free Tier) while allowing public access for local development tools like **MySQL Workbench**.

## ⚠️ Important Cost & Limitations

1.  **Public IP Cost:** AWS charges (~$3.60/month) for the public IPv4 address required to make this database accessible from your home.
2.  **Student/Starter Accounts:** Automated backups are disabled (`backup_retention_period = 0`) to comply with AWS Educate/Academy restrictions. You must take manual snapshots if you want to save data.
3.  **Single-AZ:** High Availability (Multi-AZ) is disabled to keep costs low.

## 📂 Project Structure

Ensure your directory contains these 5 files:

* `provider.tf`: AWS provider configuration.
* `variables.tf`: Configuration for Region, IP, and Credentials.
* `network.tf`: Default VPC lookup and Security Group (Firewall) rules.
* `rds.tf`: The Database instance configuration.
* `outputs.tf`: Prints the connection URL after deployment.

## 🚀 Setup Instructions

### 1. Prerequisites
* [Terraform installed](https://developer.hashicorp.com/terraform/downloads)
* AWS Credentials configured (run `aws configure` or set env vars).

### 2. Configure Your IP
Open `variables.tf` and ensure the `my_ip` variable matches your current public IP.
* *Check your IP:* Search "what is my ip" on Google.
* *Format:* `45.127.109.146/32` (Must include `/32`).

### 3. Deploy
Open your terminal in the project folder:

```bash
# 1. Initialize Terraform
terraform init

# 2. Preview the changes
terraform plan

# 3. Apply changes (Type 'yes' when asked)
# You will be prompted to enter a DB Password.
terraform apply

🔌 How to Connect (MySQL Workbench)
Once terraform apply finishes, you will see an output like this:
db_endpoint = "my-free-tier-db.cx123...us-east-1.rds.amazonaws.com:3306"
Open MySQL Workbench.

Click (+) to add a connection.

Hostname: Paste the URL from db_endpoint (remove :3306 if there is a separate Port field).

Port: 3306

Username: admin (or what you set in variables.tf).

Password: The password you typed during the apply step.

Click Test Connection.

🛠 Troubleshooting
Error: "FreeTierRestrictionError"

Ensure backup_retention_period = 0 in rds.tf.

Connection Timeout

Your home IP address may have changed.

Check your new IP on Google.

Update variables.tf with the new IP.

Run terraform apply again to update the firewall instantly.

🗑 Cleanup (Destroy)
To stop the instance and stop all charges:
terraform destroy
