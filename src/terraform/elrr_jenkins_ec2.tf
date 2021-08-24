# creates EC2 instance for the ELRR kafka

resource "aws_instance" "elrr_jenkins_master" {
  key_name      = aws_key_pair.elrr_public.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_jenkins_master"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_jenkins_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_jenkins_interface" {
  subnet_id   = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_jenkins_interface"
  }
}

# creates EC2 instance for the ELRR jenkins agent

resource "aws_instance" "elrr_jenkins_agent" {
  key_name      = aws_key_pair.elrr_public.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_jenkins_agent"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_jenkins_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_jenkins_agent_interface" {
  subnet_id   = aws_subnet.elrr_public_subnet_1.id

  tags = {
    Name = "elrr_jenkins_agent_interface"
  }
}
