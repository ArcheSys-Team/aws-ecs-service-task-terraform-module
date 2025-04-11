variable "region" {
  description = "region"
  default     = "us-east-1"
}

variable "deletion_window_in_days" {
  description = "deletion window in days"
  default     = 7
  type        = number
}

variable "ecs_cloudwatch_log_group_name" {
  description = "ecs cloudwatch log group name"
  default     = "ecs-logs"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ecs cluster name"
  default     = "ecs-cluster"
  type        = string
}

variable "logging" {
  description = "logging"
  default     = "OVERRIDE"
  type        = string
}

variable "cloud_watch_encryption_enabled" {
  description = "cloud watch encryption enabled"
  default     = true
  type        = bool
}

variable "capacity_providers" {
  description = "capacity providers"
  default     = ["FARGATE"]
  type        = list(string)
}

variable "default_capacity_provider_strategy_base" {
  description = "default capacity provider strategy base"
  default     = 1
  type        = number
}

variable "default_capacity_provider_strategy_weight" {
  description = "default capacity provider strategy weight"
  default     = 100
  type        = number
}

variable "capacity_provider" {
  description = "capacity provider"
  default     = "FARGATE"
  type        = string
}

variable "common_tags" {
  description = "Dummy variable to silence warnings"
  type        = map(string)
  default     = {}
}

variable "cluster_type" {
  description = "The type of ECS cluster (e.g., FARGATE)"
  type        = string
}

#################################

variable "Environment" {
  type = string
  validation {
    condition     = contains(["Dev", "Test", "Impl", "Prod", "Perf"], var.Environment)
    error_message = "Invalid Environment value. Must be one of 'Dev', 'Test', 'Impl', 'Prod', 'Perf'."
  }
}

variable "subnet_tag" {
  default     = []
  description = "subnet_tag"
  type        = list(string)
}

variable "data_classification" {
  type        = string
  description = "pick one of PII PHI FTI public non-public"
  validation {
    condition     = contains(["PII", "PHI", "FTI", "public", "non-public"], var.data_classification)
    error_message = "Invalid value for data_classification. Must be one of PII, PHI, FTI, public or non-public. Unsure on what to pick please contact DWO"
  }
}
variable "Domain" {
  type = string
  validation {
    condition     = contains(["healthcare.gov", "cms.gov", "medicare.gov"], var.Domain)
    error_message = "Invalid domain. Must be one of healthcare.gov, cms.gov, or medicare.gov. Unsure on what to pick please contact DWO"
  }
}

variable "BusinessOwner" {
  type        = string
  description = "Business owner"
}
variable "SystemMaintainer" {
  type        = string
  description = "system_maintainer"
}

variable "application" {
  type = string
  validation {
    condition     = can(regex("^[a-z]+$", var.application))
    error_message = "Invalid Application Name. Must be all lowercase letters and cannot contain spaces. You can find it in the AWS VPC Tags"
  }
}

variable "maintainer" {
  type        = string
  description = "ADO Maintainer Email Group or List separated by ';'"
}

variable "OE_Impacting" {
  type        = string
  description = "OE_Impacting"
}

variable "team_name" {
  type        = string
  description = "team_name"
}

variable "need_zscaler" {
  type    = bool
  default = false
}