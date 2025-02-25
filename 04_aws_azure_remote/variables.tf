variable "location" {
  description = "The location/region where the resources will be created."
  type        = string
  default     = "East US"
}

variable "account_tier" {
  description = "The storage account tier."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The storage account replication type."
  type        = string
  default     = "LRS"
}
