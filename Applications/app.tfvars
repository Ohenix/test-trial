# the app.tfvars
remote_state_key = "TEST/platform.tfstate"
remote_state_bucket = "ecs-fargate-remote-mmt"

# service variables
ecs_service_name = "app"
docker_container_port = 8080
desired_task_number = "2"
spring_profile = "default"
memory = 1024 