variable "instance_type" {
  type = string
  default = "t2.nano"
}

variable "security_group" {
  type = list(string)
  default = ["sg-075d9dc319f0a8390"]
}



