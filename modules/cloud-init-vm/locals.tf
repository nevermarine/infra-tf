locals {
  formatted_commands = length(var.extra_commands) > 0 ? formatlist("    - %s", var.extra_commands) : []
}
