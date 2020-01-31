# locals

locals {
    # Will only get the first container definition, if more than one exists
    container_definition = jsondecode(var.container_definition)[0]
    # This does not work. Says local.container_definition is a 
    #    tuple of 1 element and not a map.
    container_name = lookup(local.container_definition, "name", "error")
}

