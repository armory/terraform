resource "aws_key_pair" "alc-spin" {
  key_name   = "alc-spin"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCjyCdT5zWk9JQdm4L4yRKidV2d1oScVaHDuV3lwREa0LPUVSvoSfZezCJPrmxC9ou/ixrG4BboO1P50TqvPnIzoNZLa8Rzf7AnteQk/Bgg+CwssEkHAg2FO94q1+698INpA3ZA7LuKK5k9y0uxej+/Lf9hRRjrezTS7P1EWPgwsxHO1B/GRfOFGbFhI4KrcErKtnMBu5KGsigiiuGXunvjwAwjt7yfxr0srket7batLos6FNokJpYuzhJXRH68Srpa3LJHf3CDY07gs5Q4D0Vv6KiHgierymxcEel3x+VxJv01FxkmnUITawj/T1JfqWhIebdrc4F9WcrTD1SAdVZJAWSOWsK/2b5K81ZEyL6tVh0dC9THqJfybswkQJulJj5HPWEaHX37U//boqNwXKTeXE7GG1qZm4c6D2rZOKWDG+Y8FMJJYmb5d7Mi9BPrrdqALCd6Sso2MOTbgfThWvSCRlYI8PdD9OSsizZb8Mi7JWPpsNEJdu2f7I0PvFgTa5sAz9L8diT4kJWKPlvUV8OimWaKh1f5LdPgC9OF5lmnvYc5ajlNH3hZofwVINYEcfPEXLAFrOct20gB0gOPULlKLY8/PJTNTybpZlhPc645wF6l4Guznk6T7QpqbumeZsKO5+GxR95ySLjAyBM+Zo4QZNzgmq7AqxA80gVj0pISvQ== alice.chen@armory.io"
}

output "alc-spin-key-name" {
  value = aws_key_pair.alc-spin.key_name
}

output "alc-spin-fingerprint" {
  value = aws_key_pair.alc-spin.fingerprint
}