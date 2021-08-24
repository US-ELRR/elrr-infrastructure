Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#!/bin/bash

# copy/paste this code into the 'User Data' within the advanced tab.
# Ensure that a Instance Type with at least 4 GB RAM is used (e.g., t2.medium)

# Keep the below so the script will run on initial start-up and subsequent
# restarts.

if [ ! -d "/home/datasim/code/datasim" ] && [ ! -d "/home/datasim/code/datasim-ui" ]
 then
 if [ ! -d "/tmp/ssm" ]
 then
 echo "ssm Folder not found, making it" >> /home/ubuntu/startlog.txt
 sudo mkdir /tmp/ssm
 cd /tmp/ssm
 wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
 sudo dpkg -i amazon-ssm-agent.deb
 sudo systemctl enable amazon-ssm-agent
 fi
 # Start configuration for DATASIM folders and dependencies
 echo "making home folder" >> /home/ubuntu/startlog.txt
 if [ ! -d "/home/datasim" ]
 then
 echo "Datasim Folder not found, making it" >> /home/ubuntu/startlog.txt
 sudo mkdir /home/datasim
 fi

 cd /home/datasim
 echo "runningupdate" >> /home/ubuntu/startlog.txt
 sudo apt update
 echo "installing openjdk and curl" >> /home/ubuntu/startlog.txt
 sudo apt install openjdk-8-jre -y >> /home/ubuntu/startlog.txt
 sudo apt install curl -y >> /home/ubuntu/startlog.txt
 if [ ! -d "/home/datasim/code" ]
 then
 echo "code Folder not found, making it" >> /home/ubuntu/startlog.txt
 sudo mkdir ./code
 fi

 cd ./code >> /home/ubuntu/startlog.txt
 echo "installing git make and wrap..." >> /home/ubuntu/startlog.txt
 sudo apt install git make rlwrap -y >> /home/ubuntu/startlog.txt
 echo "git make and rlwrap installed" >> /home/ubuntu/startlog.txt
 echo "Cloning ELRR infra repo..." >> /home/ubuntu/startlog.txt
 git clone https://github.com/US-ELRR/elrr-infrastructure.git >> /home/ubuntu/startlog.txt
 echo "ELRR infra repo cloned." >> /home/ubuntu/startlog.txt

 ## Due to `nvm` not being installed as a Linux package, and AWS running the
 ## Instance Template script as 'root' - we need to execute the set-up and config of
 ## DATASIM within a sub-shell run as VM user, `ubuntu`. Running the entire script as
 ## `root` will result in an incomplete install of nvm, which will cause an error in
 ## compiling DATASIM.
 cd elrr-infrastructure/src/datasim >> /home/ubuntu/startlog.txt
 sudo chmod +x datasim-config.sh
 sudo -u ubuntu ./datasim-config.sh >> /home/ubuntu/startlog.txt

 # Check if there is a running DATASIM instance (port 9091), if so the loop is stopped
 elif ( sudo lsof -Pi :9091 -sTCP:LISTEN -t > /dev/null ); then
 break
 else
 # Option 2: Restarting an existing installation of DATAIM
 cd /home/datasim/code
 echo "Removing old elrr-infrastructure repo..." >> /home/ubuntu/startlog.txt
 rm -rf elrr-infrastructure >> /home/ubuntu/startlog.txt
 echo "Cloning ELRR infra repo..." >> /home/ubuntu/startlog.txt
 git clone https://github.com/US-ELRR/elrr-infrastructure.git >> /home/ubuntu/startlog.txt
 echo "ELRR infra repo cloned." >> /home/ubuntu/startlog.txt
 cd elrr-infrastructure/src/datasim >> /home/ubuntu/startlog.txt
 sudo chmod +x datasim-config.sh
 sudo -u ubuntu ./datasim-config.sh >> /home/ubuntu/startlog.txt
fi

# boiler plate for SSM agent installation, needed for development sandbox
. /etc/os-release
OS_TYPE=$ID
OS_VER=$VERSION_ID

{
    case $OS_TYPE in
        *"rhel"* | *"centos"*)
            if [[ $OS_VER == *"7"* ]]; then
                if [[ ! -d "/tmp/ssm" ]]; then
                    mkdir /tmp/ssm
                fi
                cd /tmp/ssm
                sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
                sudo systemctl enable amazon-ssm-agent
                sudo systemctl start amazon-ssm-agent
            elif [[ $OS_VER == *"6"* ]]; then
                if [[ ! -d "/tmp/ssm" ]]; then
                    mkdir /tmp/ssm
                fi
                cd /tmp
                sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
                sudo start amazon-ssm-agent
                sudo status amazon-ssm-agent
            elif [[ $OS_VER == *"8"* ]]; then
                if [[ ! -d "/tmp/ssm" ]]; then
                    mkdir /tmp/ssm
                fi
                cd /tmp
                sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm --disablerepo=*
                systemctl enable amazon-ssm-agent
                systemctl start amazon-ssm-agent
            fi
        ;;

        *"sles"*)
            if [[ ! -d "/tmp/ssm" ]]; then
                mkdir /tmp/ssm
            fi
            cd /tmp/ssm
            wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
            sudo rpm --install amazon-ssm-agent.rpm
            sudo systemctl enable amazon-ssm-agent
            sudo systemctl start amazon-ssm-agent
        ;;

        *"debian"*)
            if [[ ! -d "/tmp/ssm" ]]; then
                mkdir /tmp/ssm
            fi
            cd /tmp/ssm
            wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
            sudo dpkg -i amazon-ssm-agent.deb
            sudo systemctl enable amazon-ssm-agent
        ;;

        *"ubuntu"*)
            if [[ $OS_VER == *"14"* ]]; then
                if [[ ! -d "/tmp/ssm" ]]; then
                    mkdir /tmp/ssm
                fi
                cd /tmp/ssm
                wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
                sudo dpkg -i amazon-ssm-agent.deb
                sudo start amazon-ssm-agent
            elif [[ $OS_VER == *"16"* ]]; then
                if [[ ! -d "/tmp/ssm" ]]; then
                    mkdir /tmp/ssm
                fi
                cd /tmp/ssm
                wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
                sudo dpkg -i amazon-ssm-agent.deb
                sudo start amazon-ssm-agent
            elif [[ $OS_VER == *"20"* ]]; then
                if [[ ! -d "/tmp/ssm" ]]; then
                    mkdir /tmp/ssm
                fi
                sudo snap install amazon-ssm-agent --classic
                sudo snap switch --channel=candidate amazon-ssm-agent
                sudo systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
                sudo systemctl status snap.amazon-ssm-agent.amazon-ssm-agent.service
            fi
        ;;

        *"amzn"*)
            if [[ ! -d "/tmp/ssm" ]]; then
                mkdir /tmp/ssm
            fi
            cd /tmp/ssm
            sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
            sudo systemctl enable amazon-ssm-agent
            sudo systemctl start amazon-ssm-agent
        ;;
    esac

}
