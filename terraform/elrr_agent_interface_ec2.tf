# creates EC2 instance for the ELRR agent

resource "aws_instance" "elrr_agent1" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent1"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_agent_sg.id
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

  user_data  = file("user_data/elrr_agent_interface.txt")
}

resource "aws_network_interface" "elrr_agent1_interface" {
  subnet_id   = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent1_interface"
  }
}

# creates EC2 instance for the ELRR agent 2

resource "aws_instance" "elrr_agent2" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent2"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_agent_sg.id
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

  user_data  = file("user_data/elrr_agent_interface.txt")
}

resource "aws_network_interface" "elrr_agent2_interface" {
  subnet_id   = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent2_interface"
  }
}

# creates EC2 instance for the ELRR agent 3

resource "aws_instance" "elrr_agent3" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent3"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_agent_sg.id
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

  user_data  = file("user_data/elrr_agent_interface.txt")
}

resource "aws_network_interface" "elrr_agent3_interface" {
  subnet_id   = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent3_interface"
  }
}

# creates EC2 instance for the ELRR agent 4

resource "aws_instance" "elrr_agent4" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent4"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_agent_sg.id
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
  user_data  = file("user_data/elrr_agent_interface.txt")
}

resource "aws_network_interface" "elrr_agent4_interface" {
  subnet_id   = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent4_interface"
  }
}
