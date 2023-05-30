resource "aws_launch_template" "klever_template" {
  name      = var.template_data_name
  image_id  = "ami-0261755bbcb8c4a84"
  key_name  = var.key_name
  user_data = "${base64encode(local.user_data)}"

   network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.security_group.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "RKE-MASTER"
    }
  }

  depends_on = [
   var.security_group
  ]
}



resource "aws_autoscaling_group" "klever-as" {
 vpc_zone_identifier       = [var.subnets.first, var.subnets.second]
  name                      = var.as_group_data.name
  capacity_rebalance        = true
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  max_size                  = 1
  min_size                  = 1
  enabled_metrics = [
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity",
    "GroupDesiredCapacity",
    "GroupInServiceCapacity",
    "GroupInServiceInstances",
    "GroupMaxSize",
    "GroupMinSize",
    "GroupPendingCapacity",
    "GroupPendingInstances",
    "GroupStandbyCapacity",
    "GroupStandbyInstances",
    "GroupTerminatingCapacity",
    "GroupTerminatingInstances",
    "GroupTotalCapacity",
    "GroupTotalInstances",
    "WarmPoolDesiredCapacity",
    "WarmPoolMinSize",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity",
    "WarmPoolWarmedCapacity",
  ]
  mixed_instances_policy {

    instances_distribution {

      on_demand_allocation_strategy            = "prioritized"
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 0
      spot_allocation_strategy                 = "price-capacity-optimized"
      spot_instance_pools                      = 0
      spot_max_price                           = ""

    }
    launch_template {
      launch_template_specification {

        launch_template_id   = aws_launch_template.klever_template.id
        launch_template_name = aws_launch_template.klever_template.name
        version              = "$Latest"

      }
      override {
        instance_type = "t2.large"
      }

      override {
        instance_type = "t2.medium"
      }

    }
  }
  depends_on = [
    aws_launch_template.klever_template,
    var.as_group_data
  ]
}


