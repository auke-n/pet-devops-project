resource "aws_security_group" "jenkins-ec2-sg" {
  name   = "jenkins-ec2-SG"
  vpc_id = aws_vpc.devops_lab_final.id
  ingress {
    from_port       = 8080
    protocol        = "tcp"
    to_port         = 8080
    security_groups = [aws_security_group.jenkins-elb-sg.id]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkins-ec2-sg"
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
    Name = "jenkins-elb-sg"
  }
}

resource "aws_security_group" "web-elb-sg" {
  name   = "web-elb-SG"
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
    Name = "web-elb-sg"
  }
}

resource "aws_security_group" "web-ec2-sg" {
  name   = "web-SG"
  vpc_id = aws_vpc.devops_lab_final.id
  ingress {
    from_port       = 80
    protocol        = "tcp"
    to_port         = 80
    security_groups = [aws_security_group.web-elb-sg.id]
  }
  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.jenkins-ec2-sg.id]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Web-SG"
  }
}

//resource "aws_security_group" "build-sg" {
//  name   = "build-SG"
//  vpc_id = aws_vpc.devops_lab_final.id
//  ingress {
//    from_port       = 22
//    protocol        = "tcp"
//    to_port         = 22
//    security_groups = [aws_security_group.jenkins-ec2-sg.id]
//  }
//  egress {
//    from_port   = 0
//    protocol    = "-1"
//    to_port     = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//  tags = {
//    Name = "Build-SG"
//  }
//}

/*resource "aws_security_group" "build-sg" {
  name   = "build-sg"
  vpc_id = aws_vpc.devops_lab_final.id
  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.jenkins-ec2-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "build-sg"
  }
}*/
