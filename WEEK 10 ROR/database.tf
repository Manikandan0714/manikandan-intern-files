resource "aws_db_instance" "default" {
  allocated_storage      = 20
  db_name                = "myrailsdb"
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  username               = "rails_user"
  password               = var.db_password
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}