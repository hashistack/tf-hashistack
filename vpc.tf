# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc-cidr_block[terraform.workspace]

  enable_dns_hostnames = true

  tags = {
    Name        = "${var.application}.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

## SUBNETS
resource "aws_subnet" "public" {
  count = var.vpc-az_redundancy[terraform.workspace]

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index)

  availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.application}-public-${count.index}.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

resource "aws_subnet" "private" {
  count = var.vpc-az_redundancy[terraform.workspace]

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, (count.index + var.vpc-az_redundancy[terraform.workspace]))

  availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.application}-private-${count.index}.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

## DHCP OPTION SET
resource "aws_vpc_dhcp_options" "main" {
  domain_name          = "service.consul"
  domain_name_servers  = ["127.0.0.1", "AmazonProvidedDNS"]
  ntp_servers          = ["127.0.0.1"]
  netbios_name_servers = ["127.0.0.1"]
  netbios_node_type    = 2

  tags = {
    Name        = "${var.application}.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

## DHCP OPTION SET ASSOCIATION
resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id = aws_vpc.main.id

  dhcp_options_id = aws_vpc_dhcp_options.main.id
}

## INTERNET GATEWAY
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.application}.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

## NAT GATEWAYS
resource "aws_eip" "nat" {
  count = var.vpc-az_redundancy[terraform.workspace]

  vpc = true

  tags = {
    Name        = "${var.application}-${count.index}.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

resource "aws_nat_gateway" "main" {
  count = var.vpc-az_redundancy[terraform.workspace]

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name        = "${var.application}-${count.index}.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

## ROUTE TABLES
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.application}-public.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

resource "aws_route_table" "private" {
  count = var.vpc-az_redundancy[terraform.workspace]

  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.application}-private-${count.index}.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

## ROUTES
resource "aws_route" "internet_gateway-public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "nat_gateway-private" {
  count = var.vpc-az_redundancy[terraform.workspace]

  route_table_id         = aws_route_table.private[count.index].id
  nat_gateway_id         = aws_nat_gateway.main[count.index].id
  destination_cidr_block = "0.0.0.0/0"

  timeouts {
    create = "5m"
  }
}

## ROUTE TABLE ASSOCIATIONS
resource "aws_route_table_association" "public" {
  count = var.vpc-az_redundancy[terraform.workspace]

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = var.vpc-az_redundancy[terraform.workspace]

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

## SECURITY GROUPS
resource "aws_security_group" "default" {
  name        = "${var.application}-default.${terraform.workspace}.${var.domain}"
  description = "${var.application}-default security group"

  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.application}-default.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

resource "aws_security_group_rule" "in-default_all_default" {
  type = "ingress"

  protocol = "-1"

  from_port = "0"
  to_port   = "0"

  source_security_group_id = aws_security_group.default.id

  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "out-default_all_anywhere" {
  type = "egress"

  protocol = "-1"

  from_port = "0"
  to_port   = "0"

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.default.id
}
