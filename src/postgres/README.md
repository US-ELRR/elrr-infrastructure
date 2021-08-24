# ELRR - PostgreSQL Database Install and Configuration

This directory contains the code to install, configure, and run PostgreSQL databases for the Enterprise Learner Record Repository project.

## Intended use

Intended use of this code is that a user could reference the steps below, including the associated scripts within this repository, to build a PostgreSQL database server within their environment. The configuration scripts within this environment provide the baseline PostgreSQL configuration. Developers may leverage their own configuration scripts, such as automating the creation of tables and schemas.

## Capabilities and limitations

The code in this repository leverages Docker images for running majority of the core applications. While the code has been tested on AWS EC2 instances, the code should be able to run on any major cloud platform with parameter tweaks, but has not been verified. The current code base utilizes separate virtual machines (VMs) for each of the core components.
Note that connection to the database will be from the bastion host since the databases are in private subnets
Configure AWS security groups to allow appropriate ports and ips

In the future, the development team will explore running the ELRR suite using Docker Compose and/or on Kubernetes.

## Directions for use

The following steps are related to running a 2-node set-up with a Jenkins Master and Jenkins Agent using Docker. The Jenkins Agent server is essentially a 'Docker host' which dynamically spins up/down Jenkins Agent containers, as needed.


### Bastion host Setup
Download pgadmin docker compose and run 
```console
git clone https://github.com/US-ELRR/elrr-infrastructure.git
```

Change directory into postgress and run the docker-compose-pgadmin.yml file
```console
docker-compose -f docker-compose-pgadmin.yml up
```

Download private key and ssh into private instance
Setup ssh connection between bastion host and database servers and verify connections
```console
ssh -i ~/.ssh/<key-name.pem> <hostname>@<address>
```

### Install the PostgresSQL database

Pre-requisites:
- A Linux VM (Ubuntu 18.04) has been stood-up and configured (2 vCPU and 4 GB is recommended at minimum)
- You are able to SSH into your VM
- TCP 80/443 ports (inbound) are open to the Internet
- TCP 5480 port (inbound) is opened to your IP address

First, SSH into the VM. Once in the VM, run the below command to clone the ELRR infrastructure repo to the local machine:
```console
git clone https://github.com/US-ELRR/elrr-infrastructure.git
```
Once cloned successfully, navigate to the src directory for jenkins `cd elrr-infrastructure/src/postgres`. Within the directory, execute the following command to create a `database.env` file to hold the secrets for the database:
```console
nano database.env

# database.env
POSTGRES_USER=<ENTER-USERNAME>
POSTGRES_PASSWORD=<ENTER-PASSWORD>
```

Once the `database.env` file has been generated, change the permissions and run the following command to start the Postgres database:
```console
. ./postgres_install.sh
```

Post installaion steps:
```console
sudo usermod -aG docker $USER
sudo setfacl -m user:$USER:rw /var/run/docker.sock
sudo chmod +x /usr/local/bin/docker-compose
sudo systemctl enable docker
sudo systemctl status docker
```
# Install, start and enable firewalld on ubuntu
```console
sudo apt-get install firewalld -y
sudo systemctl start firewalld.service
sudo systemctl enable firewalld.service
sudo systemctl status firewalld.service
```

# Allow connections and test connection from bastion host
```console
sudo firewall-cmd --zone=public --add-port=22/tcp --permanent;
sudo firewall-cmd --zone=public --add-port=5480/tcp --permanent;
sudo firewall-cmd --reload;
```

# Test connection from bastion host
```console
telnet <ip-address> <port>
```

### After the shell completes, run the `sudo docker ps` command to capture the 'Name' of your container. Save this value. With the container name, run the following command to create an 'interactive' environment with the container.
```console
sudo docker exec -it <POSTGRES_CONTAINER_NAME> bash
```

Once the shell starts up, execute `psql -U $POSTGRES_USER` which will use the username from your `database.env` file created earlier. Congrats! You've now logged into a PostgreSQL database and are ready to provision tables and manipulate data.

Adjust PostgreSQL configuration so that remote connections to the database(s) are possible.
```console
RUN echo "host all  all  <basion-host-ip>  md5" >> /var/lib/postgresql/data/pg_hba.conf
```
And add listen_addresses to /var/lib/postgresql/data/postgresql.conf
```console
grep listen /var/lib/postgresql/data/postgresql.conf
RUN echo "listen_addresses='*'" >> /var/lib/postgresql/data/postgresql.conf
```
# Configure PostgreSQL Database
Install psql client on Ubuntu (Both on database server and bastion host)
```console
sudo apt update
sudo apt-get install postgresql-client -y
psql -V
```

# Test database connection from bastion host
```console
psql -h <database hostname/ip-address> -p <database-port> -U <database-user>
```

# Configure PostgreSQL Database
* Create database/schemas
* Create Read-Only role and Read-Write role
* Grant privileges to roles
* Create uses and password
* Grant roles to users

Note: You can either use the linux CLI or install and use pgadmin4 on windows for the databases.

## Further resources

For more details on various components for ELRR, please refer to the following documentation:
* [PostgreSQL - Install on Docker](https://docs.docker.com/engine/examples/postgresql_service/)
* [PostgreSQL - Connecting to a Local Container](https://betterprogramming.pub/connect-from-local-machine-to-postgresql-docker-container-f785f00461a7)
