variable "subnet_id" {}
variable "sg_22_80" {}
variable "sg_5000" {}
variable "install_apache" {}
variable "public_key" {}
output "ec2_id" {
  value = aws_instance.ec2.id
}
resource "aws_instance" "ec2" {
  ami           = "ami-0c1c30571d2dae5c9"
  instance_type = "t2.micro"
  tags = {
    Name = "web_server"
  }
  key_name                    = "aws_key"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_22_80, var.sg_5000]
  associate_public_ip_address = true
  user_data                   = var.install_apache
  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}
resource "aws_key_pair" "keys" {
  key_name   = "aws_key"
  public_key = var.public_key
}
