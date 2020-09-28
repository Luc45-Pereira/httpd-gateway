
## Start the clean webserver
alone:
	$(DCC) up -d;
	printf "${COLOR_COMMENT}Web server started.${COLOR_RESET}\n"

## Start the webserver with filebeat log output
start:
	$(DCC) -f docker-compose.prod.yaml up -d;
	printf "${COLOR_COMMENT}Web server started.${COLOR_RESET}\n"
	@$(RUN) bin/filebeat-restart
	printf "${COLOR_COMMENT}Filebeat started.${COLOR_RESET}\n"
	bin/up-stages.sh
	printf "${COLOR_COMMENT}Stages up.${COLOR_RESET}\n"

## Restart all stages
restart:
	$(MAKE) down;
	$(MAKE) start;

## Stop the webserver
stop:
	$(DCC) down;
	printf "${COLOR_COMMENT}Web server stoped.${COLOR_RESET}\n"

## Down all stages
down:
	$(DCC) down;
	bin/down-stages.sh
	printf "${COLOR_COMMENT}Web server and stages DOWN.${COLOR_RESET}\n"

## Start the cadvisor and node-exporter
monitor-start:
	$(DCMONITOR) up -d;
	printf "${COLOR_COMMENT}Cadivisor and node-exporter started.${COLOR_RESET}\n"

## Stop the cadvisor and node-exporter
monitor-stop:
	$(DCMONITOR) down;
	printf "${COLOR_COMMENT}Cadivisor and node-exporter stoped.${COLOR_RESET}\n"

## Test the webserver
test:
	  $(DCC) ps;
	  printf "\t\t ${COLOR_INFO}$(NGINX_RESPONSE)${COLOR_RESET} Running \n";

## Cleanup logs and temporary files
cleanup:
		sudo bin/log-cleanup.sh
		printf "${COLOR_COMMENT}Done.${COLOR_RESET}\n"