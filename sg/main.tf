variable "vpc_id" {}
variable "public_subnets_cidr" {}
output "sg_22_80" {
  value = aws_security_group.sg_22_80.id
}
output "sg_5000" {
  value = aws_security_group.sg_5000.id
}
output "sg_3306" {
  value = aws_security_group.sg_3306.id
}

resource "aws_security_group" "sg_22_80" {
  vpc_id = var.vpc_id
  name   = "sg for EC2"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}
resource "aws_security_group" "sg_5000" {
  vpc_id = var.vpc_id
  name   = "sg for flask"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
  }
}
resource "aws_security_group" "sg_3306" {
  vpc_id = var.vpc_id
  name   = "sg for mysql"
  ingress {
    cidr_blocks = var.public_subnets_cidr
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
  }
}
