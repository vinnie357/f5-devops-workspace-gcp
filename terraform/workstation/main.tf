# firewall rules
resource "google_compute_firewall" "default-allow-internal-mgmt" {
  name    = "${var.projectPrefix}default-allow-internal-mgmt-firewall${var.buildSuffix}"
  network = "${var.mgmt_vpc.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  priority = "65534"

  source_ranges = ["10.0.10.0/24"]
}
resource "google_compute_firewall" "mgmt" {
  name    = "${var.projectPrefix}mgmt-firewall${var.buildSuffix}"
  network = "${var.mgmt_vpc.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = [ "22", "443"]
  }

  source_ranges = ["${var.adminSrcAddr}"]
}
# storage bucket
resource "google_storage_bucket" "workspace-bucket" {
  name     = "${var.projectPrefix}images-storage${var.buildSuffix}"
  location = "US"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}
resource "google_storage_bucket_access_control" "workspace-bucket-rule" {
  bucket = google_storage_bucket.workspace-images.name
  role   = "OWNER"
  entity = "user-${var.sa_name}"
}
# startup script
data "template_file" "vm_onboard" {
  template = "${file("${path.root}/workspace/templates/onboard.sh")}"

  vars = {
      #var = example
  }
}
# disk
resource "google_compute_disk" "workspace_disk" {
  name  = "${var.projectPrefix}workspace-disk${var.buildSuffix}"
  type  = "pd-ssd"
  image = "${var.deviceImage}"
  physical_block_size_bytes = 4096
  size = "20"
}
resource "google_compute_image" "workspace_image" {
  name = "${var.projectPrefix}workspace${var.buildSuffix}"
  family  = "ubuntu-1804-lts"
  disk_size_gb = "20"
  project = "${var.project}"
  licenses = [ "/projects/vm-options/global/licenses/enable-vmx" ]
  source_disk = "${google_compute_disk.workspace_disk.self_link}"
}

# GCE instance
resource "google_compute_instance" "vm_instance" {
  count            = "${var.vm_count}"
  name             = "${var.projectPrefix}${var.name}-${count.index + 1}-instance${var.buildSuffix}"
  machine_type = "${var.MachineType}"
  min_cpu_platform = "Intel Haswell"
  
  boot_disk {
    initialize_params {
      image = "${google_compute_image.workspace_image.name}"
    }
  }
  
  metadata = {
    ssh-keys = "${var.adminAccountName}:${var.gce_ssh_pub_key_file}"
    block-project-ssh-keys = true
    # this is best for a long running instance as it is only evaulated and run once, changes to the template do NOT destroy the running instance.
    #startup-script = "${data.template_file.vm_onboard.rendered}"
    deviceId = "${count.index + 1}"
 }
 # this is best for dev, as it runs ANY time there are changes and DESTROYS the instances
  metadata_startup_script = "${data.template_file.vm_onboard.rendered}"

  network_interface {
    # mgmt
    # A default network is created for all GCP projects
    network       = "${var.mgmt_vpc.name}"
    subnetwork = "${var.mgmt_subnet.name}"
    # network = "${google_compute_network.vpc_network.self_link}"
    access_config {
    }
  }
    service_account {
    # https://cloud.google.com/sdk/gcloud/reference/alpha/compute/instances/set-scopes#--scopes
    email = "${var.sa_name}"
    scopes = [ "storage-rw", "logging-write", "monitoring-write", "monitoring", "pubsub", "service-management" , "service-control" ]
    # scopes = [ "storage-ro"]
  }

}