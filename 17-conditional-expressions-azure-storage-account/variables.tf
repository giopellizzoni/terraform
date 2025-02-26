variable "location" {
  description = "The location/region where the resource group will be created."
  default     = "West Europe"
  type        = string
}

variable "envinronment" {
  description = "The environment to deploy the resources."
  type        = string
}
