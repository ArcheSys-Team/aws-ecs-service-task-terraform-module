##########################################
## AWS & Terraform Provider - Variables ##
##########################################

variable "region" {
  description = "region"
  default     = "us-east-1"
}

variable "common_tags" {
  description = "Dummy variable to silence warnings"
  type        = map(string)
  default     = {}
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

variable "certificate_arn" {
  type        = string
  description = "certificate_arn"
  default     = null
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

variable "inbound_security_group" {
  type        = list(string)
  description = "inbound security group"
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

#################subnet_tags#################

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

/*variable "OE_Impacting" {
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
}*/

variable "path" {
  type        = string
  description = "path"
}

variable "load_balancer_name" {
  type        = string
  description = "load_balancer_name"
  default     = "alb"
}

variable "security_groups_ids" {
  type        = list(string)
  description = "security_groups_ids"
  default     = []
}

variable "subnet_ids" {
  type        = list(string)
  description = "subnet_ids"
  default     = []
}

variable "ecs_task_definition_family" {
  type        = string
  description = "ecs_task_definition_family"
  default     = "alb"
}

variable "ecs_launch_type" {
  type        = string
  description = "ecs_launch_type"
  default     = "FARGATE" #["FARGATE"] ["EC2"]
}

variable "container_name" {
  type        = string
  description = "container_name"
  default     = ""
}

variable "container_image" {
  type        = string
  description = "container_image"
  default     = ""
}

variable "cpu" {
  type        = number
  description = "cpu"
  default     = 256
}

variable "memory" {
  type        = number
  description = "memory"
  default     = 512
}


variable "task_memory" {
  type        = number
  description = "memory"
  default     = 512
}

variable "task_cpu" {
  type        = number
  description = "cpu"
  default     = 256
}

variable "container_port" {
  type        = number
  description = "container_port"
  default     = 80
}

variable "container_host_port" {
  type        = number
  description = "container_host_port"
  default     = 80
}

variable "container_protocol" {
  type        = string
  description = "container_protocol"
  default     = "tcp"
}

variable "ecs_service_name" {
  type        = string
  description = "ecs_service_name"
  default     = "ecs_service_name"
}

variable "container_desired_count" {
  type        = number
  description = "container_desired_count"
  default     = 2
}


variable "lb_target_group_arn" {
  type        = string
  description = "lb_target_group_arn"
  default     = "lb_target_group_arn"
}

variable "vpc_id" {
  type        = string
  description = "vpc_id"
  default     = "vpc_id"
}

variable "aws_iam_role_name" {
  type        = string
  description = "aws_iam_role_name"
  default     = "aws_iam_role_name"
}

variable "aws_iam_policy_name" {
  type        = string
  description = "aws_iam_policy_name"
  default     = "aws_iam_policy_name"
}

variable "database_user" {
  type        = string
  description = "database_user"
  default     = "database_user"
}

variable "database_password" {
  type        = string
  description = "database_password"
  default     = "database_password"
}

variable "instance_endpoint" {
  type        = string
  description = "instance_endpoint"
  default     = "instance_endpoint"
}


##########alb###########

variable "create_security_group" {
  description = "Determines if a security group is created"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  type        = string
  description = "load_balancer_type"
  default     = "application"
}

variable "target_groups" {
  description = "A list of maps containing key/value pairs that define the target groups to be created. Order of these maps is important and the index of these are to be referenced in listener definitions. Required key/values: name, backend_protocol, backend_port"
  type        = any
  default     = []
}

variable "https_listeners" {
  description = "A list of maps describing the HTTPS listeners for this ALB. Required key/values: port, certificate_arn. Optional key/values: ssl_policy (defaults to ELBSecurityPolicy-2016-08), target_group_index (defaults to https_listeners[count.index])"
  type        = any
  default     = []
}
variable "http_tcp_listeners" {
  description = "A list of maps describing the HTTP listeners or TCP ports for this ALB. Required key/values: port, protocol. Optional key/values: target_group_index (defaults to http_tcp_listeners[count.index])"
  type        = any
  default     = []
}


##################type-ec2####################

variable "network_mode" {
  type        = string
  description = "network_mode"
  default     = "awsvpc"
}

variable "launch_type" {
  type        = string
  description = "launch_type"
  default     = null
}

variable "force_new_deployment" {
  type        = bool
  description = "force_new_deployment"
  default     = null
}

variable "cluster_type" {
  description = "The type of ECS cluster (e.g., FARGATE)"
  type        = string
}

variable "ecs_cluster_id" {
  type        = number
  description = "ecs_cluster_id"
  default     = 1
}

variable "ecs_cluster_arn" {
  type        = number
  description = "ecs_cluster_arn"
  default     = 1
}


##################rds variables#########################





variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "enable_password_rotation" {
  type    = bool
  default = false
}

variable "instance_use_identifier_prefix" {
  description = "Determines whether to use `identifier` as is or create a unique identifier beginning with `identifier` as the specified prefix"
  type        = bool
  default     = false
}

variable "custom_iam_instance_profile" {
  description = "RDS custom iam instance profile"
  type        = string
  default     = null
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = null
}


variable "storage_throughput" {
  description = "Storage throughput value for the DB instance. See `notes` for limitations regarding this variable for `gp3`"
  type        = number
  default     = null
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used. Be sure to use the full ARN, not a key alias."
  type        = string
  default     = null
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate"
  type        = string
  default     = null
}

variable "license_model" {
  description = "License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1"
  type        = string
  default     = null
}

variable "replica_mode" {
  description = "Specifies whether the replica is in either mounted or open-read-only mode. This attribute is only supported by Oracle instances. Oracle replicas operate in open-read-only mode unless otherwise specified"
  type        = string
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled"
  type        = bool
  default     = false
}

variable "domain" {
  description = "The ID of the Directory Service Active Directory domain to create the instance in"
  type        = string
  default     = null
}

variable "domain_iam_role_name" {
  description = "(Required if domain is provided) The name of the IAM role to be used when making API calls to the Directory Service"
  type        = string
  default     = null
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = null
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = true
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05"
  type        = string
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot"
  type        = bool
  default     = false
}

variable "final_snapshot_identifier_prefix" {
  description = "The name which is prefixed to the final snapshot on cluster destroy"
  type        = string
  default     = "final"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = null
}

variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = null
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = null
}

variable "password" {
  description = <<EOF
  Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file.
  The password provided will not be used if the variable create_random_password is set to true.
  EOF
  type        = string
  default     = null
  sensitive   = true
}

variable "manage_master_user_password" {
  description = <<EOF
  Set to true to allow RDS to manage the master user password in Secrets Manager. 
  Cannot be set if password is provided.
  EOF
  type        = bool
  default     = true
}

variable "db_password_rotation_schedule" {
  description = <<EOF
  Set the number of days after which the DB password needs to be rotated.
  EOF
  type        = number
  default     = 7
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "availability_zone" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1' or `gp3`. See `notes` for limitations regarding this variable for `gp3`"
  type        = number
  default     = null
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60"
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero"
  type        = string
  default     = null
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled"
  type        = string
  default     = "rds-monitoring-role"
}

variable "monitoring_role_use_name_prefix" {
  description = "Determines whether to use `monitoring_role_name` as is or create a unique identifier beginning with `monitoring_role_name` as the specified prefix"
  type        = bool
  default     = false
}

variable "monitoring_role_description" {
  description = "Description of the monitoring IAM role"
  type        = string
  default     = null
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = bool
  default     = false
}

variable "monitoring_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the monitoring IAM role"
  type        = string
  default     = null
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  type        = bool
  default     = true
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = null
}

variable "blue_green_update" {
  description = "Enables low-downtime updates using RDS Blue/Green deployments."
  type        = map(string)
  default     = {}
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = null
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = null
}

variable "restore_to_point_in_time" {
  description = "Restore to a point in time (MySQL is NOT supported)"
  type        = map(string)
  default     = null
}

variable "s3_import" {
  description = "Restore from a Percona Xtrabackup in S3 (only MySQL is supported)"
  type        = map(string)
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "db_instance_tags" {
  description = "Additional tags for the DB instance"
  type        = map(string)
  default     = {}
}

variable "db_option_group_tags" {
  description = "Additional tags for the DB option group"
  type        = map(string)
  default     = {}
}

variable "db_parameter_group_tags" {
  description = "Additional tags for the  DB parameter group"
  type        = map(string)
  default     = {}
}

variable "db_subnet_group_tags" {
  description = "Additional tags for the DB subnet group"
  type        = map(string)
  default     = {}
}

# DB subnet group
variable "create_db_subnet_group" {
  description = "Whether to create a database subnet group"
  type        = bool
  default     = true
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = null
}

variable "db_subnet_group_use_name_prefix" {
  description = "Determines whether to use `subnet_group_name` as is or create a unique name beginning with the `subnet_group_name` as the prefix"
  type        = bool
  default     = true
}

variable "db_subnet_group_description" {
  description = "Description of the DB subnet group to create"
  type        = string
  default     = null
}

# DB parameter group
variable "create_db_parameter_group" {
  description = "Whether to create a database parameter group"
  type        = bool
  default     = true
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate or create"
  type        = string
  default     = null
}

variable "parameter_group_use_name_prefix" {
  description = "Determines whether to use `parameter_group_name` as is or create a unique name beginning with the `parameter_group_name` as the prefix"
  type        = bool
  default     = true
}

variable "parameter_group_description" {
  description = "Description of the DB parameter group to create"
  type        = string
  default     = null
}

variable "family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = null
}

variable "parameters" {
  description = "A list of DB parameters (map) to apply"
  type        = list(map(string))
  default     = []
}

# DB option group
variable "create_db_option_group" {
  description = "Create a database option group"
  type        = bool
  default     = true
}

variable "option_group_name" {
  description = "Name of the option group"
  type        = string
  default     = null
}

variable "option_group_use_name_prefix" {
  description = "Determines whether to use `option_group_name` as is or create a unique name beginning with the `option_group_name` as the prefix"
  type        = bool
  default     = true
}

variable "option_group_description" {
  description = "The description of the option group"
  type        = string
  default     = null
}

variable "major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = null
}

variable "options" {
  description = "A list of Options to apply"
  type        = any
  default     = []
}

variable "create_db_instance" {
  description = "Whether to create a database instance"
  type        = bool
  default     = true
}

variable "timezone" {
  description = "Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information"
  type        = string
  default     = null
}

variable "character_set_name" {
  description = "The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS and Collations and Character Sets for Microsoft SQL Server for more information. This can only be set on creation"
  type        = string
  default     = null
}

variable "nchar_character_set_name" {
  description = "The national character set is used in the NCHAR, NVARCHAR2, and NCLOB data types for Oracle instances. This can't be changed."
  type        = string
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)"
  type        = list(string)
  default     = []
}

variable "timeouts" {
  description = "Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times"
  type        = map(string)
  default     = {}
}

variable "option_group_timeouts" {
  description = "Define maximum timeout for deletion of `aws_db_option_group` resource"
  type        = map(string)
  default     = {}
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = false
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data. Valid values are `7`, `731` (2 years) or a multiple of `31`"
  type        = number
  default     = 7
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data"
  type        = string
  default     = null
}

variable "max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = 0
}

variable "ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance"
  type        = string
  default     = null
}

variable "delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted"
  type        = bool
  default     = true
}

variable "create_random_password" {
  description = "Whether to create random password for RDS primary cluster"
  type        = bool
  default     = true
}

variable "random_password_length" {
  description = "Length of random password to create"
  type        = number
  default     = 16
}

variable "network_type" {
  description = "The type of network stack to use"
  type        = string
  default     = null
}

################################################################################
# CloudWatch Log Group
################################################################################

variable "create_cloudwatch_log_group" {
  description = "Determines whether a CloudWatch log group is created for each `enabled_cloudwatch_logs_exports`"
  type        = bool
  default     = false
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "The number of days to retain CloudWatch logs for the DB instance"
  type        = number
  default     = 7
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  type        = string
  default     = null
}

variable "layer" {
  type        = string
  description = "Layer type (valid options: dmz, web, app, data, transit)"

  validation {
    condition     = contains(["dmz", "web", "app", "data", "transit"], var.layer)
    error_message = "Invalid Layer type provided. Must be one of dmz, web, app, data, or transit."
  }
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (new generation of general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. If you specify 'io1' or 'gp3' , you must also include a value for the 'iops' parameter"
  type        = string
  default     = null
}

variable "target_group_name" {
  description = "Name for the target group"
  type        = string
}

variable "target_type" {
  description = "Type of target, can be 'instance' or 'ip'"
  type        = string
}

variable "protocol" {
  description = "Type of target, can be 'instance' or 'ip'"
  type        = string
}

variable "port_targetgroup" {
  description = "Port on which targets receive traffic"
  type        = number
}

variable "health_check_path" {
  description = "The destination for the health check request"
  type        = string
  default     = "/"
}

variable "timeout" {
  description = "timeout"
  type        = string
}

variable "interval" {
  description = "interval"
  type        = string
}

variable "healthy_threshold" {
  description = "healthy_threshold"
  type        = string
}

variable "unhealthy_threshold" {
  description = "unhealthy_threshold"
  type        = string
}

variable "matcher" {
  description = "matcher"
  type        = string
}
