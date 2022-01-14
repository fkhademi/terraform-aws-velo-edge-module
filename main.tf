resource "aws_network_interface" "public" {
  subnet_id         = var.public_subnet_id
  security_groups   = [aws_security_group.public.id]
  source_dest_check = false

  tags = {
    "Name" = "${var.name}-public-interface"
  }
}

resource "aws_network_interface" "private" {
  subnet_id         = var.private_subnet_id
  security_groups   = [aws_security_group.private.id]
  source_dest_check = false

  tags = {
    "Name" = "${var.name}-private-nterface"
  }
}

resource "aws_eip" "public" {
  vpc               = true
  network_interface = aws_network_interface.public.id

  tags = {
    "Name" = "${var.name}-public-ip"
  }
}

data "aws_ami" "velo" {
  owners = ["aws-marketplace"]

  filter {
    name   = "name"
    values = ["VeloCloud VCE 3.3.1-71-R331-20190925-GA-31ebe508-57ab-4a11-ad63-89bffdedead5-ami-0806d8f5d5558de00.4"]
  }
}

resource "aws_key_pair" "key" {
  key_name   = "${var.name}-key"
  public_key = var.ssh_key
}

resource "aws_instance" "velo" {
  ami           = data.aws_ami.velo.id
  instance_type = var.instance_size
  key_name      = aws_key_pair.key.key_name

  network_interface {
    network_interface_id = aws_network_interface.public.id
    device_index         = 0
  }

 network_interface {
    network_interface_id = aws_network_interface.private.id
    device_index         = 1
  }

  tags = {
    "Name" = "${var.name}-vm"
  }
}

########
resource "aws_security_group" "public" {
  name        = "${var.name}-public-sg"
  description = "Security group for Public ${var.name} ENI"
  vpc_id      = var.vpc_id

  tags = {
    "Name" = "${var.name}-public-sg"
  }
}

resource "aws_security_group" "private" {
  name        = "${var.name}-private-sg"
  description = "Security group for private ${var.name} ENI"
  vpc_id      = var.vpc_id

  tags = {
    "Name" = "${var.name}-private-sg"
  }
}

# Inbound security group rules for public interface
resource "aws_security_group_rule" "zero" {
    type              = "egress"
    from_port         = -1
    to_port           = -1
    protocol          = -1
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public.id
    description       = "egress"
} 

resource "aws_security_group_rule" "one" {
    type              = "ingress"
    from_port         = -1
    to_port           = -1
    protocol          = "ICMP"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public.id
    description       = "icmp"
} 

resource "aws_security_group_rule" "two" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "TCP"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public.id
    description       = "SSH"
} 

resource "aws_security_group_rule" "three" {
    type              = "ingress"
    from_port         = 161
    to_port           = 161
    protocol          = "UDP"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public.id
    description       = "161"
} 

resource "aws_security_group_rule" "four" {
    type              = "ingress"
    from_port         = 2426
    to_port           = 2426
    protocol          = "UDP"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public.id
    description       = "2426"
} 

resource "aws_security_group_rule" "five" {
    type              = "ingress"
    from_port         = -1
    to_port           = -1
    protocol          = -1
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private.id
    description       = "priv"
}

resource "aws_security_group_rule" "six" {
    type              = "egress"
    from_port         = -1
    to_port           = -1
    protocol          = -1
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private.id
    description       = "egress"
} 