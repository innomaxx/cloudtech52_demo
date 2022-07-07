
variable "aws_access_key" {
  description = "AWS access key"
  default     = ""
}

variable "aws_secret_key" {
  description = "AWS secret key"
  default     = ""
}

variable "aws_ami" {
  description = "AWS AMI ID"
  default     = ""
}

variable "aws_eip_alloc_id" {
  description = "AWS EIP Allocation ID"
  default     = ""
}

variable "aws_ebs_volume_id" {
  description = "AWS EBS Volume ID"
  default     = ""
}

variable "db_host" {
  description = "App database host"
  default     = ""
}

variable "db_name" {
  description = "App database name"
  default     = ""
}

variable "db_user" {
  description = "App database user"
  default     = ""
}

variable "db_pass" {
  description = "App database password"
  default     = ""
}