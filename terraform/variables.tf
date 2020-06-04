#project
variable projectPrefix {
    description = "prefix for resources"
    default = "devops-tf-cloud-"
}
variable gcpProjectId {
  description = "project where resources are created"
}
# env
variable gcpRegion {
  description = "default region"
  default = "us-east1"
}
variable gcpZone {
  description = "default zone"
  default = "us-east1-b"
}
variable gcpServiceAccounts {
  type = map
  default = {
      storage = "default-compute@developer.gserviceaccount.com"
      compute = "default-compute@developer.gserviceaccount.com"
    }
}
# admin 
variable adminSrcAddr {
  description = "admin source range in CIDR x.x.x.x/24"
}

variable adminAccount {
  description = "admin account name"
}
variable adminPass {
  description = "admin account password"
}
variable gceSshPubKeyFile {
  description = "ssh public key for instances"
}

variable repositories {
 description = "list of urls for repos" 
}

variable onboardScript {
  description = "url for onboard script"
}

variable instanceType {
    description = "gce machine type/size"
    default = "n1-standard-4"
}