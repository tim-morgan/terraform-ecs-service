# Required

variable "project_name" {
    description = "The name of the project."
}
variable "environment" {
    description = "Environment of the service. E.g. DEV/TEST/STAGE/PROD"
}
variable "vpc_id" {
    description = "VPC ID where the resources are deployed."
}
variable "cluster" {
    description = "ECS Cluster ID."
}
variable "load_balancer_arn" {
    description = "The Load Balancer ARN."
}
variable "load_balancer_listener_arn" {
    description = "The Load Balancers Listener ARN."
}
variable "subnets" {
    type        = list(string)
    description = "The subnets associated with the service. "
}
variable "container_definition" {
    type = string
    description = "The container definition in JSON format. "
}


# Optional

variable "port" {
    description = "The port on which targets receive traffic."
    default = 80
}
variable "protocol" {
    description = "The protocol to use for routing traffic to the targets."
    default = "HTTP"
}
variable "target_type" {
    default = "ip"
}
variable "deregistration_delay" {
    default = 120
}
variable "health_check_path" {
    default = "/"
}
variable "health_check_interval" {
    default = 30
}
variable "health_check_timeout" {
    default = 5
}
variable "health_check_healthy_threshold" {
    default = 2
}
variable "health_check_unhealthy_threshold" {
    default = 5
}
variable "lb_stickiness" {
    default = true
}
variable "lb_cookie_duration" {
    default = 500
}
variable "desired_count" {
    default = 1
}
variable "ingress_security_group_ids" {
    type        = list(string)
    description = "List of ingress security group ids."
    default = null
}
variable "ingress_cidr_blocks" {
    type        = list(string)
    description = "List of ingress IPv4 CIDR blocks."
    default     = null
}
variable "ingress_ipv6_cidr_blocks" {
    type        = list(string)
    description = "List of ingress IPv6 CIDR blocks."
    default     = null
}
variable "tags" {
    type = map(string)
    description = "Tags"
    default = {}
}