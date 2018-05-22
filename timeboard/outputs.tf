output "title" {
  value       = "${join(",", datadog_timeboard.asg.*.title)}"
  description = "The title of datadog timeboard for ASG"
}
