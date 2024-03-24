variable "subnet_group_db" {}
variable "sg_db" {}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "db_sub_group"
  subnet_ids = var.subnet_group_db
}

resource "aws_db_instance" "db" {
  allocated_storage       = 10
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0.36"
  instance_class          = "db.t3.micro"
  identifier              = "mydb"
  username                = "dbuser"
  password                = "dbpassword"
  db_name                 = "devprojdb"
  vpc_security_group_ids  = [var.sg_db]
  db_subnet_group_name    = aws_db_subnet_group.db_subnet.name
  skip_final_snapshot     = true
  apply_immediately       = true
  backup_retention_period = 0
  deletion_protection     = false
}

