resource "google_compute_instance_template" "template" {
  name_prefix  = "instance-template-"
  project      = var.project_id
  region       = var.region

  machine_type = var.instance_type
  disk {
    source_image = var.image_name
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP address
    }
  }

  metadata_startup_script = var.startup_script

  lifecycle {
    create_before_destroy = true
  }

}