# security group to allow inbound connection on port 9200 & 443 for ELRR xAPI Gateway
resource "aws_security_group" "elrr_xapi_gw_sg" {
  name        = "elrr_xapi_gw_sg"
  description = "Allow TLS inbound traffic on ports 9200 & 443"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_xapi_gw_sg"
  }
}

# security group to allow SSH inbound connection
resource "aws_security_group" "elrr_xapi_gw_ssh_sg" {
  name        = "elrr_xapi_gw_ssh_sg"
  description = "Allow TLS inbound traffic on port 22"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_xapi_gw_ssh_sg"
  }
}

# security group to allow inbound on port 5453 & 443 for ELRR Storage
resource "aws_security_group" "elrr_database_sg" {
  name        = "elrr_storage_sg"
  description = "Allow Postgres connectivity"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 5453
    to_port     = 5453
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_database_sg"
  }
}

# security group to allow SSH inbound connection
resource "aws_security_group" "elrr_database_ssh_sg" {
  name        = "elrr_database_ssh_sg"
  description = "Allow TLS inbound traffic on port 22"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_database_ssh_sg"
  }
}

# security group to allow inbound on port 5453 & 443 for ELRR
resource "aws_security_group" "elrr_auth_sg" {
  name        = "elrr_auth_sg"
  description = "Allow connection from elrr auth"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 5453
    to_port     = 5453
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_auth_sg"
  }
}

# security group to allow SSH inbound connection
resource "aws_security_group" "elrr_auth_ssh_sg" {
  name        = "elrr_auth_ssh_sg"
  description = "Allow TLS inbound traffic on port 22"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_auth_ssh_sg"
  }
}

# security group to allow inbound on port 5453 & 443 for ELRR portal
resource "aws_security_group" "elrr_portal_sg" {
  name        = "elrr_portal_sg"
  description = "Allow user connectivity"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 5453
    to_port     = 5453
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_portal_sg"
  }
}

# security group to allow SSH inbound connection
resource "aws_security_group" "elrr_portal_ssh_sg" {
  name        = "elrr_portal_ssh_sg"
  description = "Allow TLS inbound traffic on port 22"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_portal_ssh_sg"
  }
}

# security group to allow inbound on port 9092, 2181, 2888 for ELRR kafka
resource "aws_security_group" "elrr_kafka_sg" {
  name        = "elrr_kafka_sg"
  description = "Allow kafka and zookeeper communication"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 2888
    to_port     = 2888
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_kafka_sg"
  }
}

# security group to allow SSH inbound connection
resource "aws_security_group" "elrr_kafka_ssh_sg" {
  name        = "elrr_kafka_ssh_sg"
  description = "Allow TLS inbound traffic on port 22"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_kafka_ssh_sg"
  }
}

# security group to allow inbound on port 9092, 5432, 443 for ELRR agent
resource "aws_security_group" "elrr_agent_sg" {
  name        = "elrr_agent_sg"
  description = "Allow elrr agent communication"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_agent_sg"
  }
}

# security group to allow SSH inbound connection
resource "aws_security_group" "elrr_agent_ssh_sg" {
  name        = "elrr_agent_ssh_sg"
  description = "Allow TLS inbound traffic on port 22"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_agent_ssh_sg"
  }
}

# security group to allow inbound on port 9091, 443 for ELRR datasim
resource "aws_security_group" "elrr_datasim_sg" {
  name        = "elrr_datasim_sg"
  description = "Allow datasim communication"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 9091
    to_port     = 9091
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_datasim_sg"
  }
}

# security group to allow SSH inbound connection
resource "aws_security_group" "elrr_datasim_ssh_sg" {
  name        = "elrr_datasim_ssh_sg"
  description = "Allow TLS inbound traffic on port 22"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_datasim_ssh_sg"
  }
}

# security group to allow inbound on port 9091, 443 for kubernetes
resource "aws_security_group" "elrr_k8_sg" {
  name        = "elrr_k8_master_sg"
  description = "Allow kubernetes communication"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 8088
    to_port     = 8088
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_k8_sg"
  }
}

# security group to allow SSH inbound connection
resource "aws_security_group" "elrr_k8_ssh_sg" {
  name        = "elrr_k8_ssh_sg"
  description = "Allow TLS inbound traffic on port 22"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_k8_ssh_sg"
  }
}

# security group to allow inbound on port 9091, 443 for Jenkins
resource "aws_security_group" "elrr_jenkins_sg" {
  name        = "elrr_jenkins_sg"
  description = "Allow jenkins communication"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 8083
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_jenkins_sg"
  }
}

# security group to allow SSH inbound connection
resource "aws_security_group" "elrr_jenkins_ssh_sg" {
  name        = "elrr_jenkins_ssh_sg"
  description = "Allow TLS inbound traffic on port 22"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_jenkins_ssh_sg"
  }
}

# security group to allow SSH inbound connection
resource "aws_security_group" "elrr_bastion_sg" {
  name        = "elrr_bastion_sg"
  description = "Allow TLS inbound traffic on port 22"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_bastion_sg"
  }
}
