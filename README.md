# Concrete CMS Docker Setup

This project provides a simple method to install Concrete CMS via Composer and run it in a Docker container. It includes a Makefile that automates common tasks such as installation, starting/stopping containers, and completely destroying the installation. **Note:** The `destroy` command will kill all Docker containers, remove volumes, images, and delete your Concrete CMS installation (the `app` folder). Use it with caution.

---

## Features

- **Easy Concrete CMS Installation:**

  Installs Concrete CMS via Composer into an `app` directory.

- **Dockerized Environment:**

  Runs Concrete CMS in a Docker container with a preconfigured Apache/PHP setup.

- **Environment Configuration:**

  Customize database settings and site configuration via a `.env` file.

- **Makefile Automation:**

  Provides targets to install, start, stop, and completely remove the installation.

---

## Prerequisites

- [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)

- [Composer](https://getcomposer.org/)

- Git (if you plan to clone this repository)

---

## Setup Instructions

**Clone the Repository:**

```
git clone <repository-url>
cd <repository-folder>
```

**Prepare the Environment File:**
Rename the file sample.env to .env and update the settings as needed:

```
DB_NAME=concrete_db
DB_USER=concrete_user
DB_PASSWORD=secret
DB_ROOT_PASSWORD=rootsecret
SITE_NAME=mysite
```

**Install Concrete CMS:**
Use the Makefile target to install Concrete CMS via Composer:

```
make concrete
```

This command will:

- Remove any existing app directory.

- Install Concrete CMS using Composer into the app directory.

- Set file permissions based on your operating system.

- Ensure that required directories (app/public/updates and app/public/application/files) exist.

**Start Docker Containers:**
Build and start the Docker containers using Docker Compose:

```
make docker-up
```

This command builds the images (if necessary) and starts all containers defined in the docker-compose.yml file.

**Stop Docker Containers:**
To stop the running containers without removing them:

```
make docker-down
```

**Destroy the Installation (WARNING):**
This command will completely remove:

- All Docker containers, volumes, images, and orphan containers associated with this project.
- The entire Concrete CMS installation (the app folder).

```
make destroy
```

Use this command with extreme caution---once executed, you will need to reinstall Concrete CMS if you wish to continue working on the project.

## Additional Notes

### Environment Isolation

Each project's containers, images, and volumes are isolated by using the `SITE_NAME` variable in your `.env` file. This prevents conflicts when running multiple sites on the same host.

### Logs and Debugging

Running `docker-compose up` without the `-d` flag attaches container logs to your terminal, allowing you to see PHP errors and other output in real time.

### Destroy Command Warning

The `destroy` command completely removes all containers, volumes, images, and the Concrete CMS installation (the `app` folder). Use this command only when you are sure you want to wipe your current setup.
