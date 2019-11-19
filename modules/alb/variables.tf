variable "internal" {
  default     = true
  type        = bool
  description = "Whether the LB should face Internet."
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnets for LBs to live in."
}

variable "http_ports" {
  type        = list(tuple([number, number]))
  description = "The port pair of HTTP services. The first of each pair is the port opened on ALB, that clients access. The second of each pair is the port opened on service. The parameter is in form of \"[[80, 8000], [8123, 8123]]\"."
}

variable "https_ports_certs" {
  type        = list(tuple([number, number, string]))
  description = "The port/cert pair of HTTPS services. The first of each pair is the port opened on ALB, that clients access. The second of each pair is the port opened on service. The third of each pair is the cert ARN for the ALB port. The parameter is in form of \"[[80, 8000, \"arn:aws:XXX\"], [8123, 8123, \"arn:aws:YYYY\"]]\"."
}

variable "redirect_ports" {
  type        = list(tuple([number, number]))
  description = "The port pair for port redirect. The first of each pair is the port client requests. The second of each pair is the port to tell the client to request. The parameter is in form of \"[[80, 443]]\"."
}

variable "ssl_policy" {
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
  description = "The name of the SSL Policy for the listener. Required if protocol is HTTPS."
}

variable "alb_sg_id" {
  type        = string
  description = "A security group ID to assign to the LB."
}

variable "vpc_id" {
  type        = string
  description = "The identifier of the VPC in which to create the target groups."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for aws_lb resource."
}

variable "name_prefix" {
  type = string
}	
