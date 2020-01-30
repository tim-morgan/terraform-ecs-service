

resource "aws_security_group" "ecs_tasks" {
    name        = "${var.project_name}_${var.environment}_sg"
    description = "Allow inbound access from the ALB only"
    vpc_id      = var.vpc_id

    ingress {
        from_port = var.port
        to_port   = var.port
        protocol  = "tcp"
        security_groups = var.ingress_security_group_ids
        cidr_blocks      = var.ingress_cidr_blocks
        ipv6_cidr_blocks = var.ingress_ipv6_cidr_blocks
    }

    # Allow all
    egress {
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}