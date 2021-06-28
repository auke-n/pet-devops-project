resource "aws_instance" "jenkins-server" {
  ami                         = "ami-043097594a7df80ec"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_pbl1.id
  key_name                    = "lab"
  vpc_security_group_ids      = [aws_security_group.jenkins-ec2-sg.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  user_data                   = file("config/user_data_jenkins.sh")
  tags = {
    Name = "jenkins"
  }
  lifecycle {
    ignore_changes = [public_ip, public_dns]
  }
}

resource "aws_instance" "web-server" {
  ami                         = "ami-043097594a7df80ec"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_pbl2.id
  key_name                    = "lab"
  vpc_security_group_ids      = [aws_security_group.web-ec2-sg.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  user_data                   = file("config/user_data_web_server.sh")
  tags = {
    Name = "web-server"
  }
  lifecycle {
    ignore_changes = [public_ip, public_dns]
  }
}


resource "aws_instance" "build-server" {
  ami                         = "ami-043097594a7df80ec"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_pbl1.id
  key_name                    = "lab"
  vpc_security_group_ids      = [aws_security_group.jenkins-ec2-sg.id, aws_security_group.build-sg.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  user_data                   = file("config/user_data_build_server.sh")

  tags = {
    Name = "build-server"
  }
  lifecycle {
    ignore_changes = [public_ip, public_dns, instance_state]
  }
}
