resource "aws_security_group" "petclinic-sg" {
  name   = "Petclinic-SG"
  vpc_id = aws_vpc.devops_lab_final.id
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Petclinic-SG"
  }
}
