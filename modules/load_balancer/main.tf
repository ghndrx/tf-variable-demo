resource "google_compute_backend_service" "backend_service" {
  name        = "backend-service"
  project     = var.project_id
  #region     = var.region

  backend {
    group = var.backend_instance_group_self_link
  }

  health_checks = [google_compute_health_check.default_http.self_link]
}

resource "google_compute_health_check" "default_http" {
  name        = "default-http-health-check"
  project     = var.project_id
  check_interval_sec = 30
  timeout_sec       = 5
  http_health_check {
    port = 80
  }
}

resource "google_compute_url_map" "url_map" {
  name        = "url-map"
  project     = var.project_id
  default_service = google_compute_backend_service.backend_service.self_link
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name        = "http-proxy"
  project     = var.project_id
  url_map     = google_compute_url_map.url_map.self_link
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name        = "forwarding-rule"
  project     = var.project_id
  target      = google_compute_target_http_proxy.http_proxy.self_link
  port_range  = "80"
  ip_address  = google_compute_global_address.lb_address.address
}

resource "google_compute_global_address" "lb_address" {
  name    = "lb-address"
  project = var.project_id
}
