variable "location" {
  description = "The location/region where the resource group will be created."
  default     = "West Europe"
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this Storage Account. Valid options are Standard and Premium."
  default     = "Standard"
  type        = string
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this Storage Account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RA_GZRS."
  default     = "LRS"
  type        = string

}

variable "resource_group_name" {
  description = "The name of the resource group in which the Storage Account will be created."
  default     = "rg-tf-course"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the Storage Account."
  default     = "gpsatfcourse"
  type        = string
}

variable "storage_container_name" {
  description = "The name of the Storage Container."
  default     = "gpcontainertf"
  type        = string

}
