output "template_rendered" {
  description = "List of IDs of instances"
  value       = "${data.template_file.jmeter.rendered}"
}

