# ELRR - Infrastructure
This repository contains Terraform scripts to deploy necessary resources to run the Enterprise Learner Record Repository.
# Intended Use
This repository is inteded for deploying infrastructure resources.

# Install aws-cli
```
sudo apt install awscli
```

# Configure aws role to deploy resources listed in the templates
IAM role should have enough privileges to deploy listed resources in the templates.

AWS Configure to authenticate using IAM role:
```
aws configure
```

Paste AWS access key for the user then click enter
Paste AWS secret key for the user then click enter

IAM role should be configured and ready to use Terraform.

# Installing Terraform
If Terraform is not installed, run commands below (example shown for Ubuntu OS. For others, navigate here: https://learn.hashicorp.com/tutorials/terraform/install-cli)

Add the HashiCorp GPG Key:
```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

Add the official HashiCorp Linux repository:
```
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

Update and Install Terraform:
```
sudo apt-get update && sudo apt-get install terraform
```

Verify:
```
terraform -help
```

# Using Terraform

Clone the elrr-infrastructure repository:

```
git clone https://github.com/US-ELRR/elrr-infrastructure.git
```

Navigate to 'elrr-infrastructure/terraform' directory.
```
cd elrr-infrastructure/terraform
```

Initialize the working directory with Terraform configuration templates.
```
terraform init
```

When existing Terraform templates have been modified or new templates are created, it is good practice to format the files. This can be done by running a simple format command.
```
terraform fmt
```

Now it is time to plan out the build using Terraform. Once templates are formatted and directory is initialize, Terraform is ready to plan its deployment. This is a crucial step before applying the templates into the environment. Terraform plan will run through all Terraform configuration templates and output a list of resources that will be launched. It will also output any errors that are identified in the templates whether it is syntax error, missing variables, spelling, etc.
```
terraform plan
```

When Terraform plan output looks as expected and any errors have been fixed, it is time to apply. It is important to understand what is being deployed and plan out the cost of resources being created. Terraform apply will run through the templates and output a list of resources to be created once more and have the system operator running the command confirm with a simple yes or no answer. When ready to deploy, enter yes and Terraform will work its magic and create an entire infrastructure or specified resources that have been defined in the Terraform templates.
```
terraform apply
```

Resources deployed using Terraform templates can be deleted using a simple command. Below command will destroy all resources created from terraform apply command above.
```
terraform destroy
```
