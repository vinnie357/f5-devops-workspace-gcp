# provider
provider "google" {
  credentials = "${var.serviceAccountFile}"
  project     = "${var.gcpProjectId}"
  region      = "${var.gcpRegion}"
  zone        = "${var.gcpZone}"
}

# networks
resource "google_compute_network" "vpc_network_mgmt" {
  name                    = "${var.projectPrefix}terraform-network-mgmt-${random_pet.buildSuffix.id}"
  auto_create_subnetworks = "false"
  routing_mode = "REGIONAL"
}
resource "google_compute_subnetwork" "vpc_network_mgmt_sub" {
  name          = "${var.projectPrefix}mgmt-sub-${random_pet.buildSuffix.id}"
  ip_cidr_range = "10.0.10.0/24"
  region        = "${var.gcpRegion}"
  network       = "${google_compute_network.vpc_network_mgmt.self_link}"

}
# workspace machine
module "workstation" {

  source   = "./workstation"
  #======================#
  # application settings #
  #======================#
  name = "workspace"
  adminSrcAddr = "${var.adminSrcAddr}"
  mgmt_vpc = "${google_compute_network.vpc_network_mgmt}"
  mgmt_subnet = "${google_compute_subnetwork.vpc_network_mgmt_sub}"
  gce_ssh_pub_key_file = "${var.gceSshPubKeyFile}"
  adminAccountName = "${var.adminAccount}"
  projectPrefix = "${var.projectPrefix}"
  region = "${var.gcpRegion}"
  project = "${var.gcpProjectId}"
  buildSuffix = "-${random_pet.buildSuffix.id}"
  terraformVersion = "${var.terraformVersion}"
  terragruntVersion = "${var.terragruntVersion}"
  repositories = "${var.repositories}"
}
resource "random_pet" "buildSuffix" {
  keepers = {
    # Generate a new pet name each time we switch to a new AMI id
    #ami_id = "${var.ami_id}"
    prefix = "${var.projectPrefix}"
  }
  #length = ""
  #prefix = "${var.projectPrefix}"
  separator = "-"
}