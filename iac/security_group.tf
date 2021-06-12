resource "aws_security_group" "web-sg" {
  name   = "web-SG"
  vpc_id = aws_vpc.devops_lab_final.id
  ingress {
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "-SG"
  }
  lifecycle {}
}

resource "aws_security_group" "jenkins-ec2-sg" {
  name   = "jenkins-ec2-SG"
  vpc_id = aws_vpc.devops_lab_final.id
  ingress {
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkins-SG"
  }
}

resource "aws_security_group" "jenkins-elb-sg" {
  name   = "jenkins-elb-SG"
  vpc_id = aws_vpc.devops_lab_final.id
  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkins-SG"
  }
}