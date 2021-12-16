# generate a random string with no special characters and use as suffix
resource "random_string" "suffix" {
  length  = 10
  upper   = false
  special = false
}

output "suffix" {
  value = random_string.suffix.id
}
