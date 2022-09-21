resource "aws_security_group" "main" {
  name        = "asg-${local.cluster_name}"
  description = "${local.cluster_name} ASG security group"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Environment = var.environment
    Automation  = "Terraform"
  }
}

resource "aws_security_group_rule" "main" {
  description       = "All outbound"
  security_group_id = aws_security_group.main.id

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
#lb Security group
resource "aws_security_group" "lb_sg" {
  name        = "LB${local.cluster_name}"
  description = "LB security group"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Environment = var.environment
    Automation  = "Terraform"
  }
}

#lb Security group rules
resource "aws_security_group_rule" "https_from_anywhere" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_sg.id
}

resource "aws_security_group_rule" "outbound_internet_access" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_sg.id
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
   
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
}

resource "aws_route_table_association" "route_table_association" {
    subnet_id      = var.public_subnets
    route_table_id = aws_route_table.public.id
}