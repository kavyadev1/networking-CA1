# networking-CA1
Automated Container deployment and Administration in the cloud

This project automates the deployment of a web application using terraform,ansible,docker and GitHub actions. The goal is to set up the EC2 instance on aws, configure with docker and deploy a simple web application inside a docker container, then the process is fully automated through the CI/CD pipe line.

project structure:

main.tf- terraform configuration setup.yml-configure EC2 instance inventory.ini-files contain the EC2 instance details ci-cd-pipeline.yml- GitHub action pipeline configuration file docker file- to build the container for the simple web page index.html-the simple web page file

Prerequisites:

1.aws account 2.docker hub installed 3.ansible installed 4.github account 5.terraform installed

setup infrastructure:

1.terraform setup

install terraform run the following command in the vs code terminal to provision your ec2 instance

commands:

aws configure ## (enter your access key and secret key) terraform init terraform apply

after running the terraform script will get the EC2 instance ip address in the terminal

copy the instance ip address and paste in the inventory.ini file

command:

[web] XX.XX.XX.XX ansible_ssh_user=ubuntu ansible_ssh_private_key_file=/path/to/your/private/key.pem

ansible setup: install ansible run the following command

command :

ansible-playbook -i Inventory.ini setup.yml

3.CI/CD PIPELINE:

save the Dockerfile and index.html in the repository ensure that you have added the docker hub credentials in the Github secret DOCKER_USERNAME and DOCKER_PASSWORD. then setup the your EC2 SSH private key as the Github secret EC2_SSH_PRIVATE_KEY. this CI/CD is configured to automatically build and push docker image in the docker hub whenever the changes are pushed to the main branch .

1.build_and_push:

Automatically builds a Docker image from the Dockerfile. Tags the image with your Docker Hub username and latest tag. Pushes the image to Docker Hub.

deploy:

Deploys the Docker container to the EC2 instance after the image is pushed. The EC2 instance pulls the latest Docker image, stops any existing container, and runs the new container.

4.docker setup

the Dockerfile builds the docker container using the ngnix image. it pulls the index.html file to the ngnix directory and runs in port 80 so that the application can be accessed via HTTP.

The build and deployment of the Docker container are fully automated in the CI/CD pipeline. You do not need to manually run docker build or docker run.

5.ACCESSING THE APPLICATION:

after the pipeline is completed, the application will be available at the EC2 instance ip. you can access it via http://<public_ip> in your web browser.

to find the EC2 instance ip, you can go back to the terraform instance output :

instance_ip = <public_ip>

Configuration Details:

AWS Region: eu-west-1 EC2 Instance Type: t2.micro Security Group: Configured to allow SSH (port 22) and HTTP (port 80) traffic.
