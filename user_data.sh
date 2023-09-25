#!/bin/bash

# Update the package list and install required dependencies
# sudo apt update -y
# sudo apt upgrade -y
# sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# # Add the Docker GPG key
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# # Add the Docker repository
# echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# # Update the package list again to include Docker repository
# sudo apt update

# # Install Docker
# sudo apt install -y docker-ce docker-ce-cli containerd.io

# # Start and enable Docker service
# sudo systemctl start docker
# sudo systemctl enable docker

# # Add your user to the docker group to run Docker without sudo
# sudo usermod -aG docker $USER

# # Change the folder ownership to ubuntu to have permitions to run docker
# sudo chown ubuntu:ubuntu /var/run/docker.sock

# # Install AWS CLI
# sudo apt install -y awscli