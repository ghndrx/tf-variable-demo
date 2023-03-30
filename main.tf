provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

module "firewall_rules" {
  source     = "./modules/firewall_rules"
  project_id = var.project_id
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
