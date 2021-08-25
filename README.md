# elrr-infrastructure

This directory contains the code to install, configure, and run infrastructure associated with the Enterprise Learner Record project.

## Intended use

Intended use of this code is that a user could reference the steps below, including the associated scripts within this repository, to build a ELRR application within their own environment.

## Directions for use

Navigate to the `src` folder and select the component you wish to configure. At this time, we recommend each component is installed on a separate VM for performance and stability reasons. The build for ELRR consists of the following components:
- xAPI Gateway
* [Datasim](https://github.com/US-ELRR/elrr-infrastructure/tree/main/src/datasim)
* [Jenkins](https://github.com/US-ELRR/elrr-infrastructure/blob/main/src/jenkins/README.md)
* [Postgres](https://github.com/US-ELRR/elrr-infrastructure/blob/main/src/jenkins/README.md)
* [Terraform](https://github.com/US-ELRR/elrr-infrastructure/blob/main/src/terraform/README.md)
* [Kafka-Zookeeper](https://github.com/US-ELRR/elrr-infrastructure/blob/main/src/kafka-zookeeper/README.md)
* [Kubernetes](https://github.com/US-ELRR/elrr-infrastructure/blob/main/src/kubernetes/README.md)

Each component contains its own file and README for installation / configuration within their respective folder in the `src` folder.

## Capabilities and limitations

The code in this repository leverages Docker images for running majority of the core applications. While the code has been tested on AWS EC2 instances, the code should be able to run on any major cloud platform with parameter tweaks, but has not been verified. The current code base utilizes separate virtual machines (VMs) for each of the core components

IN the future, the development team will explore running the ELRR suite using Docker Compose and/or on Kubernetes.

## Further resources

For more details on various components for ELRR, please refer to the following documentation:
* [Jenkins - Installing on Docker](https://www.jenkins.io/doc/book/installing/docker/)
* [PostgreSQL - Install on Docker](https://docs.docker.com/engine/examples/postgresql_service/)
