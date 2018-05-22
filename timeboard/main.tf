resource "datadog_timeboard" "asg" {
  count = "${var.enabled}"

  title       = "${var.product_domain} - ${var.asg_name} - ASG"
  description = "A generated timeboard for ASG"

  template_variable {
    default = "${var.asg_name}"
    name    = "asg_name"
    prefix  = "autoscaling_group"
  }

  graph {
    title     = "Group Size"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.autoscaling.group_total_instances{$asg_name} by {autoscaling_group}"
      type = "line"
    }

    request {
      q    = "avg:aws.autoscaling.group_max_size{$asg_name} by {autoscaling_group}"
      type = "line"

      style {
        type = "dashed"
      }
    }

    request {
      q    = "avg:aws.autoscaling.group_min_size{$asg_name} by {autoscaling_group}"
      type = "line"

      style {
        type = "dashed"
      }
    }

    request {
      q    = "avg:aws.autoscaling.group_desired_capacity{$asg_name} by {autoscaling_group}"
      type = "line"

      style {
        type = "dashed"
      }
    }
  }

  graph {
    title     = "Group Instances"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.autoscaling.group_pending_instances{$asg_name} by {autoscaling_group}"
      type = "line"
    }

    request {
      q    = "avg:aws.autoscaling.group_standby_instances{$asg_name} by {autoscaling_group}"
      type = "line"
    }

    request {
      q    = "avg:aws.autoscaling.group_terminating_instances{$asg_name} by {autoscaling_group}"
      type = "line"
    }

    request {
      q    = "avg:aws.autoscaling.group_total_instances{$asg_name} by {autoscaling_group}"
      type = "line"

      style {
        type = "dotted"
      }
    }
  }
}
