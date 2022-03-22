####  data #### 

data "aws_caller_identity" "current" {}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id
 tags = {
    Name = "*Public*"
  }
}

data "aws_availability_zones" "zones" {
  state = "available"
}

####  IAM #### 

resource "aws_iam_role" "task" {
  name                     = "${var.project}-${var.environment}-task-role"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
  
}

resource "aws_iam_role_policy_attachment" "task" {
  role       = aws_iam_role.task.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}



####  NW #### 

resource "aws_lb_target_group" "app" {
  deregistration_delay = "30"

  health_check {
    enabled             = "true"
    healthy_threshold   = "2"
    interval            = "10"
    matcher             = "200"
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "2"
    unhealthy_threshold = "2"
  }

  load_balancing_algorithm_type = "round_robin"
  name                          = "${var.project}-${var.environment}"
  port                          = var.port
  protocol                      = "HTTP"
  slow_start                    = "120"
  target_type                   = "ip"
  vpc_id                        = data.aws_vpc.selected.id

  lifecycle {
    create_before_destroy = true
  }
}


####  NSG #### 


resource "aws_security_group" "allow-external" {
  description = "Allows external traffic"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "443"
    protocol    = "tcp"
    self        = "false"
    to_port     = "443"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "8080"
    protocol    = "tcp"
    self        = "false"
    to_port     = "8080"
  }
   ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    protocol    = "tcp"
    self        = "false"
    to_port     = "80"
  }

  name   = "${var.project}-${var.environment}_allow-external-ecs"
  vpc_id = data.aws_vpc.selected.id
}


#### alb ####

resource "aws_lb" "lb" {
  name               = "${var.project}-${var.environment}"
  load_balancer_type = "application"
  internal           = false
  subnets          = data.aws_subnet_ids.public.ids


  security_groups = [aws_security_group.allow-internal.id, aws_security_group.allow-external1.id]
}

resource "aws_security_group" "allow-internal" {
  description = "Allows all traffic within the VPC"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = "80"
    protocol    = "tcp"
    self        = "false"
    to_port     = "80"
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = "443"
    protocol    = "tcp"
    self        = "false"
    to_port     = "443"
  }

  name   = "${var.project}-${var.environment}_allow-internal"
  vpc_id = data.aws_vpc.selected.id
}

resource "aws_security_group" "allow-external1" {
  description = "Allows external https traffic"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "443"
    protocol    = "tcp"
    self        = "false"
    to_port     = "443"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    protocol    = "tcp"
    self        = "false"
    to_port     = "80"
  }

  name   = "${var.project}-${var.environment}_allow-external"
  vpc_id = data.aws_vpc.selected.id
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
   type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
