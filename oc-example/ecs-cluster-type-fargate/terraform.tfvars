######################
# AWS Authentication #
######################
region                         = "us-east-1"
deletion_window_in_days        = 7
ecs_cloudwatch_log_group_name  = "ecs-log017"
ecs_cluster_name               = "ecs-cluster017"
logging                        = "OVERRIDE"
cloud_watch_encryption_enabled = true
capacity_providers             = ["FARGATE"]
capacity_provider              = "FARGATE"
load_balancer_name             = "nginx-applica1tion-loadbancer017"
ecs_task_definition_family     = "nginx-task-017"
ecs_launch_type                = "FARGATE"
launch_type                    = null
container_name                 = "nginx-container017"
container_image                = "51092835/djangofeb1:latest"
cpu                            = 256
memory                         = 512
task_cpu                       = 512
task_memory                    = 1024
container_port                 = 80
container_host_port            = 80
container_protocol             = "tcp"
ecs_service_name               = "nginx-service017"
container_desired_count        = 2
path                           = "/delegatedadmin/developer/"
subnet_tag                     = ["private-a", "private-b"]
cluster_type                   = "FARGATE"
inbound_security_group         = ["sg-017f85afd87ffcba9"]

target_groups = []

https_listeners = []

http_tcp_listeners = []

load_balancer_type = "application"

force_new_deployment = null

target_group_name   = "cms-oc017"
target_type         = "ip"
protocol            = "HTTP"
port_targetgroup    = "80"
health_check_path   = "/"
timeout             = 5
interval            = 30
healthy_threshold   = "5"
unhealthy_threshold = "2"
matcher             = "200-404"
certificate_arn     = "arn:aws:acm:us-east-1:180672039436:certificate/b3e885f9-e88b-4e67-bf51-a67a72bee1a7"


###################################
## tags Variables ##
###################################
application         = "abc"
Environment         = "def"
BusinessOwner       = "Test Bo Owner"
SystemMaintainer    = "Test system maintainer"
Domain              = "archesys"
data_classification = "non-public"
maintainer          = "Archesys"
#OE_Impacting        = "no"
#team_name           = "datadaog tag team name test"
#need_zscaler        = false
layer               = "web"

###################################
## Postgres ##
###################################
identifier                     = "my-rds-instance017"
instance_use_identifier_prefix = false
allocated_storage              = "20"
storage_type                   = "gp3"
storage_encrypted              = true
port                           = "5432"
create_db_instance             = true

# general config vars. 

manage_master_user_password   = false
enable_password_rotation      = false
db_password_rotation_schedule = 7

# to deploy mysql

username             = "abc"
engine               = "postgres"
engine_version       = "14.12"
family               = "postgres14"
major_engine_version = "14"
instance_class       = "db.t3.micro"
license_model        = "postgresql-license"
db_name              = "bcd"


vpc_id = ""
subnet_ids = [""]
security_groups_ids = [""] 
common_tags = {
  "name" = "value"
}
