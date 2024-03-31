all :
	make build
	make up

build :
	@docker compose -f ./srcs/docker-compose.yml build #make re 같은거

up :
	@docker compose -f ./srcs/docker-compose.yml up -d #

down :
	@docker compose -f ./srcs/docker-compose.yml down

start :
	@docker compose -f ./srcs/docker-compose.yml start

stop :
	@docker compose -f ./srcs/docker-compose.yml stop

erase :
	docker rm -f `docker ps -aq`
	docker rmi -f `docker images -aq`

cache :
	docker builder prune

fclean:
	docker stop `docker ps -aq`
	docker rm -f `docker ps -aq`
	docker rmi -f `docker images -aq`
	docker compose -f ./srcs/docker-compose.yml down --volumes

re:
	make fclean
	make all

.PHONY: all build up down start stop down-volumes erase cache fclean ls re