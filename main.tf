provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

resource "google_project_service" "compute_engine_api" {
  project = var.project_id
  service = "compute.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy         = false
}

  disable_dependent_services = true
}
module "compute_engine_template" {
  source = "./modules/compute_engine_template"
  project_id  = var.project_id
  region      = var.region
  image_name  = var.image_name
  instance_type = var.instance_type
  startup_script = file("${path.module}/scripts/startup.sh")
}

module "compute_engine_instance_group" {
  source = "./modules/compute_engine_instance_group"
  project_id  = var.project_id
  region      = var.region
  template_self_link = module.compute_engine_template.self_link
}

module "load_balancer" {
  source = "./modules/load_balancer"
  project_id  = var.project_id
  region      = var.region
  backend_instance_group_self_link = module.compute_engine_instance_group.self_link
}
