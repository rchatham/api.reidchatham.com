# image
USERNAME=rchatham
IMAGE_NAME=api.reidchatham.com
VERSION=2.0.0-beta1
CONTAINER_NAME=api.reidchatham.com-container
# CONTAINER_PORT=80
# EXPOSED_PORT=80

docker_build:
	docker build -t $(IMAGE_NAME):$(VERSION) .

# docker_run:
# 	docker run -it --name=$(CONTAINER_NAME) -p $(CONTAINER_PORT):$(EXPOSED_PORT) $(IMAGE_NAME):$(VERSION)
#
# docker_build_run: docker_build docker_run
#
# docker_run_prod:
# 	docker run -p $(CONTAINER_PORT):$(EXPOSED_PORT) $(USERNAME)/$(IMAGE_NAME):$(VERSION)
#
# docker_stop:
# 	docker stop $(CONTAINER_NAME)
#
# docker_remove:
# 	docker rm $(CONTAINER_NAME)
#
# docker_stop_rm: docker_stop docker_remove
#
# docker_restart:
# 	docker restart $(CONTAINER_NAME)

docker_tag:
	docker tag $(IMAGE_NAME):$(VERSION) $(USERNAME)/$(IMAGE_NAME):$(VERSION)

docker_push:
	docker push $(USERNAME)/$(IMAGE_NAME):$(VERSION)

# # postgres
# POSTGRES_CONTAINER_NAME=postgres-container
# POSTGRES_CONTAINER_PORT=5432
# POSTGRES_EXPOSED_PORT=5432
# POSTGRES_ENV_FILE=env/postgres.env
#
# docker_postgres:
# 	docker run -d -it --name=$(POSTGRES_CONTAINER_NAME) -p $(POSTGRES_CONTAINER_PORT):$(POSTGRES_EXPOSED_PORT) --env-file=$(POSTGRES_ENV_FILE) postgres
#
# docker_run_postgres: docker_postgres
# 	docker run -d -it --name=$(CONTAINER_NAME) -p $(CONTAINER_PORT):$(EXPOSED_PORT) --link $(POSTGRES_CONTAINER_NAME):postgres $(IMAGE_NAME):$(VERSION)
#
# docker_build_run_postgres: docker_build docker_run_postgres
#
# docker_stop_postgres:
# 	docker stop $(POSTGRES_CONTAINER_NAME)
#
# docker_rm_postgres:
# 	docker rm $(POSTGRES_CONTAINER_NAME)
#
# docker_stop_rm_postgres: docker_stop_postgres docker_rm_postgres

# # dev
# # run docker with current directory mounted to app folder in container
# docker_run_dev:
# 	docker run -d -it --name=$(CONTAINER_NAME) -v $(pwd):/app -p $(CONTAINER_PORT):$(EXPOSED_PORT) $(IMAGE_NAME):$(VERSION)
#
# docker_build_run_dev: docker_build docker_run_dev
#
# docker_run_postgres_dev: docker_postgres
# 	docker run -it --name=$(CONTAINER_NAME) -v $(pwd):/app -p $(CONTAINER_PORT):$(EXPOSED_PORT) --link $(POSTGRES_CONTAINER_NAME):postgres $(IMAGE_NAME):$(VERSION)
#
# docker_build_run_postgres_dev: docker_build docker_run_postgres_dev
#
# docker_stop_rm_all: docker_stop_rm docker_stop_rm_postgres

# docker-compose
docker_compose_dev:
	docker-compose -f docker-compose-dev.yml up

docker_compose_dev_down:
	docker-compose -f docker-compose-dev.yml down

# docker-machine
DIGITALOCEAN_TOKEN_FILE=digital-ocean.token
DIGITALOCEAN_TOKEN=`cat $(DIGITALOCEAN_TOKEN_FILE)`
DIGITALOCEAN_DROPLET_NAME=api.reidchatham.com-sandbox

docker_machine_do_launch:
	docker-machine create --driver=digitalocean --digitalocean-access-token $(DIGITALOCEAN_TOKEN) $(DIGITALOCEAN_DROPLET_NAME)
	docker-machine env $(DIGITALOCEAN_DROPLET_NAME)

docker_machine_do_launch_2:
	docker-machine create --driver=digitalocean --digitalocean-access-token $(DIGITALOCEAN_TOKEN) $(DIGITALOCEAN_DROPLET_NAME)-2
	docker-machine env $(DIGITALOCEAN_DROPLET_NAME)-2

docker_machine_do_launch_3:
	docker-machine create --driver=digitalocean --digitalocean-access-token $(DIGITALOCEAN_TOKEN) $(DIGITALOCEAN_DROPLET_NAME)-3
	docker-machine env $(DIGITALOCEAN_DROPLET_NAME)-3

# attach shell to docker machine
docker_machine_do_eval:
	eval $(docker-machine env api.reidchatham.com-sandbox)

docker_machine_do_eval_2:
	eval $(docker-machine env api.reidchatham.com-sandbox-2)

docker_machine_do_eval_3:
	eval $(docker-machine env api.reidchatham.com-sandbox-3)


docker_machine_ls:
	docker-machine ls

docker_machine_do_ip:
	docker-machine ip $(DIGITALOCEAN_DROPLET_NAME)

docker_machine_ssh:
	docker-machine ssh $(DIGITALOCEAN_DROPLET_NAME)

docker_machine_stop:
	docker-machine stop $(DIGITALOCEAN_DROPLET_NAME)

docker_machine_rm:
	docker-machine rm $(DIGITALOCEAN_DROPLET_NAME)

docker_machine_unset:
	docker-machine env -u
	eval $(docker-machine env -u)

#swarm
SWARM_NAME=api-reidchatham-com

docker_stack_deploy:
	docker stack deploy -c docker-compose.yml $(SWARM_NAME)

docker_stack_ps:
	docker stack ps $(SWARM_NAME)

docker_stack_rm:
	docker stack rm $(SWARM_NAME)

docker_swarm_init:
	docker swarm init

docker_swarm_leave:
	docker swarm leave --force
