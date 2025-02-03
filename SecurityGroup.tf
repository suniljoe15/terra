resource "aws_security_group" "web-sg" {
  name        = "Terraform-SG"
  description = "Terraform http & RDP allow"
  vpc_id      = aws_vpc.web-vpc.id

  tags = {
    Name = "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http_allow_all" {
  security_group_id = aws_security_group.web-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "rdp_allow_ip" {
  security_group_id = aws_security_group.web-sg.id
  cidr_ipv4         = "103.163.248.19/32"
  from_port         = 3389
  ip_protocol       = "tcp"
  to_port           = 3389
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress" {
  security_group_id = aws_security_group.web-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
