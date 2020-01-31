# locals

local {
    container_definition = jsondecode(var.ontainer_definition)
    container_name = lookup(container_definition, "name", "error")
}

