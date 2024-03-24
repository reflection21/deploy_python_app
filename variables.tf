variable "vpc_cidr_block" {
  type = string
}
variable "cidr_public_subnets" {
  type = list(string)
}
variable "cidr_private_subnets" {
  type = list(string)
}
variable "availability_zone" {
  type = list(string)
}
variable "public_key" {
  type = string
}
