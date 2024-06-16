variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project = "expense"
    Environment = "dev"
    Terraform = "true"
    Component = "backend"
  }
}

variable "zone_name" {
  default = "sivakumar.cloud"
  
}
variable "zone_id" {
  default = "Z08704261IRDUWFCULY6E"
  
}
                                        