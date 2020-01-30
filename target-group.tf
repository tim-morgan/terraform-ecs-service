resource "aws_lb_target_group" "target-group" {
    name = "${var.project_name}-${var.environment}-lb-tg"
    port = var.port 
    protocol = var.protocol
    target_type = var.target_type
    vpc_id = var.vpc_id
    deregistration_delay = var.deregistration_delay
    health_check {
        enabled = true

        path     = var.health_check_path
        protocol = "HTTP"
        matcher  = "200"

        interval            = var.health_check_interval
        timeout             = var.health_check_timeout
        healthy_threshold   = var.health_check_healthy_threshold
        unhealthy_threshold = var.health_check_unhealthy_threshold        
    }
    stickiness {
        enabled = var.lb_stickiness
        type = "lb_cookie"
        cookie_duration = var.lb_cookie_duration
    }
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_lb_listener_rule" "lb_listener_rule" {
    listener_arn = var.load_balancer_listener_arn   
    # TODO: Handle priority
    priority     = 1000  # ??

    condition {
        path_pattern {
            values = [ "*" ]
        }
    }

    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.target-group.arn
    }
}