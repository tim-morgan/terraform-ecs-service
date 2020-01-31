# locals

locals {
    container_definition = jsondecode(var.container_definition)
    container_name = lookup(local.container_definition, "name", "error")
}

