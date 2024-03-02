GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

# help
TARGET_MAX_CHAR_NUM=20
help:
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^# (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 2, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

# run docker-compose
run:
	docker-compose down -v --remove-orphans &&\
	docker-compose pull &&\
	docker-compose up --build

# init redis with some data
init-redis:
	docker exec -d redis redis-cli -c FLUSHALL &&\
	docker exec -d redis redis-cli -c --cluster call 0.0.0.0:7000 HSET "context-fields:{1}" "user_type" "5" &&\
	docker exec -d redis redis-cli -c --cluster call 0.0.0.0:7000 HSET "feature-flags:{1}" "COOL_FEATURE" '[[{"context_key":"user_type","operator":1,"value":2}]]' &&\
	docker exec -d redis redis-cli -c --cluster call 0.0.0.0:7000 SADD "private-keys:{1}" "gAAAAABl4ujXiEAr28ERd98PGjKuzgQ8mm5kOTJNd2FyMskpb3WRsQkDxW0QIh63hfWWkGTfd5ruP7b98l1X38amEI3zwhEpT3-UZA2-HnvS38gnvk9MtF_tUGW99_XximdMOGz1uJhT4E4PiY8jMCPMlkbQhp8iKuabVXSN4UTZ4_1cMMjYWxE="
