# Makefile
# Determine OS and set ownership command accordingly.
ifeq ($(shell uname), Darwin)
	CHOWN_CMD = sudo chown -R $(whoami):staff app
else
	CHOWN_CMD = sudo chown -R www-data:www-data app
endif

# Target to install Concrete CMS using Composer into the 'app' directory.
concrete:
	@echo "Installing Concrete CMS via Composer into the 'app' directory..."
	# Remove any existing 'app' folder to avoid issues with a read-only file system
	rm -rf app
	composer create-project concrete5/composer app
	@echo "Setting file permissions as per Concrete CMS documentation..."
	$(CHOWN_CMD)
	@echo "Ensuring app/public/updates exists..."
	[ -d app/public/updates ] || mkdir -p app/public/updates
	[ -d app/public/application/files ] || mkdir -p app/public/application/files
	chmod -R 775 app/public/application/files app/public/application/config app/public/packages app/public/updates



# Target to start Docker containers via docker-compose.
docker-up:
	@echo "Starting Docker containers..."
	docker-compose up --build

# Target to stop Docker container and volumes associated with this project.
docker-down:
	@echo "Stopping Docker containers..."
	docker-compose down

# Target to destroy this project's Docker containers and volumes.
destroy:
	@echo "Stopping and removing Docker containers, volumes, images, and orphan containers for this project..."
	docker-compose down -v --rmi all --remove-orphans
	# Remove any existing 'app' folder to avoid issues with a read-only file system
	rm -rf app