module "timeboard_asg_beical-asg" {
  source         = "../../"
  product_domain = "BEI"
  asg_name       = "beical-asg"
}
