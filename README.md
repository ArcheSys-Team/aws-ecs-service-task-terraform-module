# Terraform AWS Elastic Container Service Module.

### Overview

This Terraform module provides a comprehensive solution for provisioning Amazon ECS clusters with support for both EC2 and Fargate launch types. The module includes configurations for IAM roles and policies, task definitions, services, logging, and optional features like auto-scaling, encryption, and capacity providers.

### Features
1. ECS Cluster creation (EC2 and Fargate support)  
2. IAM roles and policies for ECS tasks  
3. ECS Task Definitions and Services  
4. CloudWatch logging configuration  
5. Auto-scaling support for EC2-based clusters  
6. KMS encryption support for logs  


## Backend Configuration (backend.conf)
This module uses a backend.conf file to configure the storage of the Terraform state file in an S3 bucket and to use a DynamoDB table for state locking. This ensures secure and consistent management of infrastructure state.

## Explanation of backend.conf parameters:
Bucket: The S3 bucket used to store the state file. In this case, it's set to "oc-terraform-pocs-backend-bucket-180672039436".
Key: The path within the S3 bucket where the state file will be saved. In this case, it's "oc-terraform-aws-ecs/cluster.tfstate".
Region: The AWS region where the S3 bucket resides. For this module, it's "us-east-1".
Encrypt: Specifies whether to encrypt the state file. Set to true to ensure that the state file is encrypted.
DynamoDB Table: Specifies a DynamoDB table (e.g., "oc-terraform-pocs-backend-table-180672039436") used for state locking and consistency.

## State File Location
The Terraform state file will be stored in the S3 bucket under the path:

```hcl
s3://oc-terraform-pocs-backend-bucket-180672039436/oc-terraform-aws-ecs/ecs-infra.tfstate
```

## Usage
This project provides a 3-tier architecture deployment using **Amazon ECS**, **ALB**, and **RDS**. The infrastructure is modularized into three separate Terraform state files to allow independent deployment and management of:

1. **Cluster and Load Balancer (ALB)**  
   - ECS Cluster (Fargate)  
   - Application Load Balancer (ALB)  
   - IAM roles for cluster execution  
   - Networking setup (subnets, VPC)  
   - Security Groups  

2. **RDS Database**  
   - Amazon RDS instance  
   - Associated security groups and parameters  

3. **ECS Service and Task Definitions**  
   - ECS Services and Task execution roles  
   - Target Groups associated with ALB  
   - Service-to-Service communication setup  

### Structure

The repository includes a complete example stack under the `examples/` folder. By making minimal changes, you can use this stack to deploy the architecture by referencing pre-built modules for ALB, networking, IAM, tags, security groups, RDS, and ECS services.

#### Deployment Workflow

1. **Deploy Cluster and ALB**  
   Use the following Terraform commands to deploy the ECS cluster and ALB.  

   ```bash
   terraform init -reconfigure -backend-config="alb-and-ecs-cluster-backend.conf"
   terraform plan/apply 
                   -target=module.iam \
                   -target=module.network \
                   -target=module.oc-tags \
                   -target=module.security-groups \
                   -target=module.ecs-cluster-fargate-module
   ```

2. **Deploy RDS**  
   Ensure that the ECS cluster and networking stack are deployed before proceeding with the RDS module.  

   ```bash
   terraform init -reconfigure -backend-config="rds-backend.conf"
   terraform plan/apply -target=module.rds
   ```

3. **Deploy ECS Service and Tasks**  
   Finally, deploy the ECS services, task definitions, and ALB target groups to complete the stack.  

   ```bash
   terraform init -reconfigure -backend-config="ecs-service-backend.conf"
   terraform plan/apply 
                   -target=module.ecs-service \
                   -target=module.task-definitions \
                   -target=module.target-groups
   ```

#### Key Features

- **Modular Design**: Independent modules for ALB, ECS, and RDS allow flexibility and reusability.  
- **Minimal Configuration**: Example stack demonstrates a functional setup with minimal configuration changes.  
- **Scalable and Secure**: Includes best practices for networking, IAM, and security groups.

### Example Folder

The `examples/` folder contains a complete stack that references the following modules:  
- `alb-module`: Provisions the Application Load Balancer.  
- `network-module`: Sets up VPC, subnets, and related networking resources.  
- `iam-module`: Configures IAM roles for ECS task execution.  
- `tags-module`: Applies consistent tagging across resources.  
- `security-groups-module`: Sets up security groups for ECS and ALB.  
- `ecs-cluster-fargate-module`: Provisions an ECS cluster with Fargate tasks.  
- `rds-module`: Provisions Amazon RDS for database needs.  

### Notes

- **Order of Deployment**: The deployment order is critical to ensure dependencies are resolved:  
  1. Deploy Cluster and ALB  
  2. Deploy RDS  
  3. Deploy ECS services, tasks, and target groups

- **State File Naming Consistency**: Ensure that the state file names in `backend.conf` match the corresponding configurations in `data.tf`. This is crucial as the state files are interrelated. An example of how to configure `backend.conf` and `data.tf` consistently is shown below:

#### Example: `backend.conf`

```hcl
bucket         = "oc-terraform-pocs-backend-bucket-180672039436"
key            = "oc-terraform-aws-ecs-bucket/alb1-and-ecs-cluster-backend.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "oc-terraform-pocs-backend-table-180672039436"
```

#### Example: `data.tf`

```hcl
data "terraform_remote_state" "alb-and-ecs-cluster-backend" {
  backend = "s3"
  config = {
    bucket = "oc-terraform-pocs-backend-bucket-180672039436"
    key    = "oc-terraform-aws-ecs-bucket/alb1-and-ecs-cluster-backend.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "ecs-cluster-task-and-service" {
  backend = "s3"
  config = {
    bucket = "oc-terraform-pocs-backend-bucket-180672039436"
    key    = "oc-terraform-aws-ecs-bucket/ecs1-cluster-task-and-service.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "rds-mysql" {
  backend = "s3"
  config = {
    bucket = "oc-terraform-pocs-backend-bucket-180672039436"
    key    = "oc-terraform-aws-ecs-bucket/rds-mysql.tfstate"
    region = "us-east-1"
  }
}
```

- **Security Groups**: The setup uses a combination of required security groups recommended by CMS and custom groups to ensure proper isolation and access control. Additionally, one security group allows outbound traffic to `0.0.0.0/0`, enabling inbound traffic to access endpoints securely.

- **Backend Configuration**: Update backend configurations appropriately for each module.

- **Commands**: Use the `-target` flag in Terraform to apply only the required modules during each phase. 

---

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.9 |

---

## Resources

| Name | Type | Description |
|------|------|-------------|
| [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | Resource | Defines the target group for the load balancer. |
| [aws_lb_listener_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | Resource | Defines listener rules for the load balancer. |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | Resource | Creates IAM roles for ECS task execution. |
| [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | Resource | IAM policy for ECS task execution. |
| [aws_ecs_task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | Resource | Defines the ECS task. |
| [aws_ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | Resource | Manages ECS services. |

---

## Inputs


| Name                                    | Description                                                                                          | Default Value        | Type        |
|-----------------------------------------|------------------------------------------------------------------------------------------------------|----------------------|-------------|
| `region`                                | The AWS region for resources.                                                                         | `us-east-1`          | `string`    |
| `deletion_window_in_days`               | Number of days to wait before deletion of resources.                                                 | `7`                  | `number`    |
| `ecs_cloudwatch_log_group_name`         | The name of the ECS CloudWatch log group.                                                             | `ecs-logs`           | `string`    |
| `ecs_cluster_name`                      | The name of the ECS cluster.                                                                          | `ecs-cluster`        | `string`    |
| `logging`                               | The logging configuration.                                                                            | `OVERRIDE`           | `string`    |
| `cloud_watch_encryption_enabled`        | Boolean flag to enable CloudWatch log encryption.                                                     | `true`               | `bool`      |
| `capacity_providers`                    | List of ECS capacity providers.                                                                       | `["FARGATE"]`        | `list(string)`|
| `default_capacity_provider_strategy_base`| Base for the default capacity provider strategy.                                                      | `1`                  | `number`    |
| `default_capacity_provider_strategy_weight`| Weight for the default capacity provider strategy.                                                   | `100`                | `number`    |
| `capacity_provider`                     | ECS capacity provider (e.g., FARGATE).                                                                | `FARGATE`            | `string`    |
| `common_tags`                           | Tags to be applied to all resources to silence warnings.                                              | `{}`                 | `map(string)`|
| `Environment`                           | Environment type (e.g., Dev, Test, Prod).                                                             | *Required*           | `string`    |
| `subnet_tag`                            | Tags for subnet configuration.                                                                       | `[]`                 | `list(string)`|
| `data_classification`                   | Classification of data (e.g., PII, PHI, FTI, public).                                                | *Required*           | `string`    |
| `Domain`                                | Domain type (e.g., healthcare.gov, cms.gov).                                                          | *Required*           | `string`    |
| `BusinessOwner`                         | The name of the business owner.                                                                       | *Required*           | `string`    |
| `SystemMaintainer`                      | The system maintainer's name.                                                                         | *Required*           | `string`    |
| `application`                           | Application name (lowercase only, no spaces).                                                         | *Required*           | `string`    |
| `maintainer`                            | Email group or list separated by semicolons.                                                          | *Required*           | `string`    |
| `OE_Impacting`                          | Whether the system is OE impacting.                                                                   | *Required*           | `string`    |
| `team_name`                             | The name of the responsible team.                                                                     | *Required*           | `string`    |
| `need_zscaler`                          | Boolean flag to specify if ZScaler integration is needed.                                             | `false`              | `bool`      |
| `path`                                  | Path configuration.                                                                                 | *Required*           | `string`    |
| `load_balancer_name`                    | Name of the load balancer.                                                                           | `alb`                | `string`    |
| `security_groups_ids`                   | List of security group IDs.                                                                           | `[]`                 | `list(string)`|
| `subnet_ids`                            | List of subnet IDs for the ECS instances.                                                             | `[]`                 | `list(string)`|
| `ecs_task_definition_family`            | ECS task definition family name.                                                                     | `alb`                | `string`    |
| `ecs_launch_type`                       | ECS launch type (e.g., FARGATE or EC2).                                                               | `FARGATE`            | `string`    |
| `container_name`                        | Name of the container in ECS.                                                                         | `""`                 | `string`    |
| `container_image`                       | Image to use for the ECS container.                                                                   | `""`                 | `string`    |
| `cpu`                                   | Number of CPU units for the ECS task.                                                                 | `256`                | `number`    |
| `memory`                                | Amount of memory in MB for the ECS task.                                                              | `512`                | `number`    |
| `task_memory`                           | Memory allocated for the ECS task.                                                                   | `512`                | `number`    |
| `task_cpu`                              | CPU allocated for the ECS task.                                                                      | `256`                | `number`    |
| `container_port`                        | Port number for the container.                                                                        | `80`                 | `number`    |
| `container_host_port`                   | Port number on the host for the container.                                                            | `80`                 | `number`    |
| `container_protocol`                    | Protocol for the container.                                                                           | `tcp`                | `string`    |
| `ecs_service_name`                      | Name of the ECS service.                                                                              | `ecs_service_name`   | `string`    |
| `container_desired_count`               | Desired count of container instances.                                                                 | `2`                  | `number`    |
| `lb_target_group_arn`                   | ARN of the load balancer target group.                                                                | `lb_target_group_arn`| `string`    |
| `vpc_id`                                | ID of the VPC in which ECS resources will be created.                                                | `vpc_id`             | `string`    |
| `aws_iam_role_name`                     | Name of the IAM role for ECS tasks.                                                                   | `aws_iam_role_name`  | `string`    |
| `aws_iam_policy_name`                   | Name of the IAM policy for ECS tasks.                                                                 | `aws_iam_policy_name`| `string`    |


---

## Outputs

This section describes the outputs for the ECS and ALB resources created by this Terraform configuration. These outputs can be used for further integration or reference in other parts of your infrastructure setup.

### ECS Cluster

| Name                                      | Description                                                                                       |
|-------------------------------------------|---------------------------------------------------------------------------------------------------|
| `ecs_cluster_arn`                         | The Amazon Resource Name (ARN) of the ECS cluster.                                                 |
| `ecs_cluster_name`                        | The name of the ECS cluster.                                                                      |

### ECS Task Definition

| Name                                      | Description                                                                                       |
|-------------------------------------------|---------------------------------------------------------------------------------------------------|
| `ecs_task_definition_arn`                 | The ARN of the ECS task definition.                                                                |
| `ecs_task_definition_revision`            | The revision number of the ECS task definition.                                                   |
| `ecs_task_definition_family`              | The family name of the ECS task definition.                                                       |

### ECS Service

| Name                                      | Description                                                                                       |
|-------------------------------------------|---------------------------------------------------------------------------------------------------|
| `ecs_service_arn`                         | The ARN of the ECS service created for this configuration.                                        |
| `ecs_service_name`                        | The name of the ECS service.                                                                      |
| `ecs_service_id`                          | The unique ID of the ECS service.                                                                  |
| `ecs_service_status`                      | The status of the ECS service (e.g., `ACTIVE`, `DRAINING`).                                        |
| `ecs_service_task_definition`             | The task definition used by the ECS service.                                                      |

### ECS Container

| Name                                      | Description                                                                                       |
|-------------------------------------------|---------------------------------------------------------------------------------------------------|
| `ecs_container_name`                      | The name of the ECS container.                                                                    |
| `ecs_container_image`                     | The Docker image used for the ECS container.                                                      |
| `ecs_container_port`                      | The port exposed by the ECS container.                                                            |
| `ecs_container_host_port`                 | The host port for the ECS container.                                                              |
| `ecs_container_protocol`                  | The protocol used for the ECS container (e.g., `tcp`, `udp`).                                     |
---
