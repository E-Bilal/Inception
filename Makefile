all: build up

up:
	docker-compose -f srcs/docker-compose.yml up 

down:
	docker-compose -f srcs/docker-compose.yml down

build:
	docker-compose -f srcs/docker-compose.yml build

re:
	docker-compose -f srcs/docker-compose.yml up 

.PHONY: re down build