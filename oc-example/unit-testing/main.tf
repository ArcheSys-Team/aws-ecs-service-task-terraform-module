module "iam" {
  source = "git::https://github.cms.gov/OC-SHARED-RESOURCES/oc-terraform-aws-shared-data-module//modules/iam?ref=main"
}

module "network" {
  source      = "git::https://github.cms.gov/OC-SHARED-RESOURCES/oc-terraform-aws-shared-data-module//modules/network?ref=main"
  Environment = var.Environment
  Application = var.application
  aws_region  = var.region
  subnets     = var.subnet_tag

}

module "oc-tags" {
  source             = "git::https://github.cms.gov/OC-SHARED-RESOURCES/oc-terraform-aws-shared-data-module//modules/oc-tags?ref=main"
  Environment        = var.Environment
  BusinessOwner      = var.BusinessOwner
  SystemMaintainer   = var.SystemMaintainer
  Domain             = var.Domain
  Application        = var.application
  Dataclassification = var.data_classification
  Maintainer         = var.maintainer
  OE_Impacting       = var.OE_Impacting
  team_name          = var.team_name
}

module "security-groups" {
  source             = "git::https://github.cms.gov/OC-SHARED-RESOURCES/oc-terraform-aws-shared-data-module//modules/security-groups?ref=main"
  region             = var.region
  Environment        = var.Environment
  BusinessOwner      = var.BusinessOwner
  SystemMaintainer   = var.SystemMaintainer
  Domain             = var.Domain
  Application        = var.application
  Dataclassification = var.data_classification
  Maintainer         = var.maintainer
  OE_Impacting       = var.OE_Impacting
  team_name          = var.team_name
  need_zscaler       = var.need_zscaler
}

module "ecs-cluster-fargate-module" {
  source                                    = "git::https://github.cms.gov/OC-SHARED-RESOURCES/oc-terraform-aws-ecs-cluster//module/ecs-cluster?ref=wetgsre-37"
  deletion_window_in_days                   = var.deletion_window_in_days
  ecs_cloudwatch_log_group_name             = var.ecs_cloudwatch_log_group_name
  ecs_cluster_name                          = var.ecs_cluster_name
  logging                                   = var.logging
  cloud_watch_encryption_enabled            = var.cloud_watch_encryption_enabled
  capacity_providers                        = var.capacity_providers
  capacity_provider                         = var.capacity_provider
  common_tags                               = module.oc-tags.application_tags #{} 
  default_capacity_provider_strategy_weight = var.default_capacity_provider_strategy_weight
  default_capacity_provider_strategy_base   = var.default_capacity_provider_strategy_base
  cluster_type                              = var.cluster_type
}