resource "aws_db_instance" "my_db" {
  identifier = "my-free-tier-db"

  # --- Engine & Instance Class ---
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  
  # --- Credentials ---
  username             = var.db_username
  password             = var.db_password
  db_name              = var.db_name
  parameter_group_name = "default.mysql8.0"

  # --- Storage ---
  allocated_storage     = 20
  storage_type          = "gp2"
  max_allocated_storage = 0

  # --- Connectivity ---
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # --- High Availability & Backup ---
  multi_az = false 
  
  # FIXED: Disabled automated backups to bypass "FreeTierRestrictionError"
  backup_retention_period = 0
  
  # --- Maintenance ---
  auto_minor_version_upgrade = true
  skip_final_snapshot        = true
}