output "instance_group_url" {
  value = module.compute_engine_instance_group.self_link
}

output "load_balancer_ip" {
  value = module.load_balancer.ip_address
}
