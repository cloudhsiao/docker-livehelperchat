
PROJECT=test
EXTERNAL_PORT=8080

LHC_ADM_USR=admin
LHC_ADM_PWD=password
LHC_ADM_EMAIL=admin@example.com

MYSQL_DATABASE=lhc
MYSQL_USER=lhc
MYSQL_PASSWORD=lhc
MYSQL_RANDOM_ROOT_PASSWORD=true

build: docker-compose.yml
	docker-compose build

start:
	@echo "EXTERNAL_PORT=$(EXTERNAL_PORT)" > .env
	@echo "MYSQL_DATABASE=$(MYSQL_DATABASE)" >> .env
	@echo "MYSQL_USER=$(MYSQL_USER)" >> .env
	@echo "MYSQL_PASSWORD=$(MYSQL_PASSWORD)" >> .env
	@echo "MYSQL_RANDOM_ROOT_PASSWORD=$(MYSQL_RANDOM_ROOT_PASSWORD)" >> .env
	docker-compose -p $(PROJECT) up -d

config:
	@http POST localhost:$(EXTERNAL_PORT)/index.php/site_admin/install/install/1
	@http --form POST localhost:$(EXTERNAL_PORT)/index.php/site_admin/install/install/2 DatabaseUsername=$(MYSQL_USER) DatabasePassword=$(MYSQL_PASSWORD) DatabaseHost=db DatabasePort=3306 DatabaseDatabaseName=$(MYSQL_DATABASE)
	@http --form POST localhost:$(EXTERNAL_PORT)/index.php/site_admin/install/install/3 AdminUsername=$(LHC_ADM_USR) AdminPassword=$(LHC_ADM_PWD) AdminPassword1=$(LHC_ADM_PWD) AdminEmail=$(LHC_ADM_EMAIL) DefaultDepartament=head AdminName= AdminSurname=

stop:
	@echo "EXTERNAL_PORT=$(EXTERNAL_PORT)" > .env
	docker-compose -p $(PROJECT) stop

clean:
	@echo "EXTERNAL_PORT=$(EXTERNAL_PORT)" > .env
	docker-compose -p $(PROJECT) stop
	docker-compose -p $(PROJECT) down

