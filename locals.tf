# locals

locals {
    container_definition = jsondecode(var.container_definition)
    container_name = lookup(var.container_definition, "name", "error")
}

