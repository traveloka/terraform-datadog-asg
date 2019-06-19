locals {
  monitor_enabled = "${var.enabled && length(var.recipients) > 0 ? 1 : 0}"
}

resource "datadog_timeboard" "asg" {
  count = "${var.enabled ? 1 : 0}"

  title       = "${var.product_domain} - ${var.cluster} - ${var.environment} - ASG"
  description = "A generated timeboard for ASG"

  template_variable {
    default = "${var.cluster}"
    name    = "cluster"
    prefix  = "cluster"
  }

  template_variable {
    default = "${var.environment}"
    name    = "environment"
    prefix  = "environment"
  }

  graph {
    title     = "Group Size"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.autoscaling.group_total_instances{$cluster, $environment} by {autoscaling_group}"
      type = "line"
    }

    request {
      q    = "avg:aws.autoscaling.group_max_size{$cluster, $environment} by {autoscaling_group}"
      type = "line"

      style {
        type = "dashed"
      }
    }

    request {
      q    = "avg:aws.autoscaling.group_min_size{$cluster, $environment} by {autoscaling_group}"
      type = "line"

      style {
        type = "dashed"
      }
    }

    request {
      q    = "avg:aws.autoscaling.group_desired_capacity{$cluster, $environment} by {autoscaling_group}"
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
      q    = "avg:aws.autoscaling.group_pending_instances{$cluster, $environment} by {autoscaling_group}"
      type = "line"
    }

    request {
      q    = "avg:aws.autoscaling.group_standby_instances{$cluster, $environment} by {autoscaling_group}"
      type = "line"
    }

    request {
      q    = "avg:aws.autoscaling.group_terminating_instances{$cluster, $environment} by {autoscaling_group}"
      type = "line"
    }

    request {
      q    = "avg:aws.autoscaling.group_total_instances{$cluster, $environment} by {autoscaling_group}"
      type = "line"

      style {
        type = "dotted"
      }
    }
  }
}
