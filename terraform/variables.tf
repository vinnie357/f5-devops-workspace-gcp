#project
variable "projectPrefix" {
    description = "prefix for resources"
}
variable "gcpProjectId" {
  description = "project where resources are created"
}
# env
variable "gcpRegion" {
  description = "default region"
}
variable "gcpZone" {
  description = "default zone"
}
variable "gcpServiceAccounts" {
  type = "map"
  default = {
      storage = "default-compute@developer.gserviceaccount.com"
      compute = "default-compute@developer.gserviceaccount.com"
    }
}
# admin 
variable "adminSrcAddr" {
  description = "admin source range in CIDR x.x.x.x/24"
}

variable "adminAccount" {
  description = "admin account name"
}
variable "adminPass" {
  description = "admin account password"
}
variable "gceSshPubKeyFile" {
  description = "ssh public key for instances"
}

variable "serviceAccountFile" {
  description = "cloud service account json"
}