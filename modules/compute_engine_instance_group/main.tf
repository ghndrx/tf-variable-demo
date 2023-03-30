resource "google_compute_instance_group_manager" "instance_group" {
  name        = "instance-group"
  project     = var.project_id
  #region      = var.region
  base_instance_name = "instance"
 
    version {
        name              = "webserver"
        instance_template = var.template_self_link
    }
    
  target_size  = 2
}