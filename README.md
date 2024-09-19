
# Project: Multi-Tier Private Cloud with Bastion Host and Load Balancer

## Overview

This project sets up a secure, scalable cloud infrastructure using AWS services. It leverages Terraform to create and manage resources in a Virtual Private Cloud (VPC) with both public and private subnets. The architecture includes EC2 instances, a NAT Gateway, a Bastion Host, and a Load Balancer for high availability and fault tolerance. 

## Components

### 1. **VPC (Virtual Private Cloud)**
   - Provides a logically isolated environment for your resources.

### 2. **Internet Gateway (IGW)**
   - Connects the VPC to the internet, enabling resources in public subnets to access the internet.

### 3. **Public Subnets**
   - Two public subnets are created with a public route table.
   - These subnets contain internet-facing resources, like the Bastion Host.

### 4. **Private Subnets**
   - Two private subnets with a private route table are created.
   - These subnets are isolated from the internet but can access it through the NAT Gateway.
   - EC2 instances running Nginx are located here.

### 5. **Route Tables**
   - **Public Route Table**: Routes traffic from the public subnets to the Internet Gateway.
   - **Private Route Table**: Routes traffic within the VPC and to the NAT Gateway for internet access from private subnets.

### 6. **NAT Gateway**
   - Allows instances in private subnets to access the internet for updates and maintenance tasks.
   - It uses an Elastic IP to have a public IP address.

### 7. **Elastic IP**
   - Provides a static public IP address for the NAT Gateway, ensuring consistent access to the internet.

### 8. **Security Groups**
   - Act as virtual firewalls to control inbound and outbound traffic for the instances.
   - Different security groups are used for the Bastion Host, Nginx servers, and the Load Balancer.

### 9. **Bastion Host**
   - A single EC2 instance in the public subnet that serves as a secure entry point (SSH jump box) to manage private instances.
   - Allows secure SSH access to Nginx servers in private subnets.

### 10. **Nginx Instances**
   - Two EC2 instances running Nginx, located in private subnets.
   - These servers handle web traffic but are not directly accessible from the internet.
   - The instances are connected to the Load Balancer for high availability.

### 11. **Load Balancer**
   - Distributes incoming traffic across the two Nginx instances, ensuring high availability, fault tolerance, and scalability.

## Architecture Diagram

![Screenshot 1](https://github.com/mohamedesmael10/terraform-aws-project/raw/main/Shots/1.jpeg)

The diagram represents the VPC with public and private subnets, EC2 instances, NAT Gateway, Bastion Host, and Load Balancer.

## How to Connect

1. **SSH to Bastion Host**: 
   - Use the Bastion Host to securely connect to the private Nginx servers.
   
2. **Access Nginx Servers**:
   - Once connected to the Bastion Host, you can SSH into the Nginx servers located in the private subnets for management and maintenance.

## Benefits

- **Security**: 
   - The private subnets isolate sensitive resources.
   - The NAT Gateway restricts outbound internet access for private instances while allowing them to fetch updates.
   
- **Scalability**:
   - Additional Nginx instances can be added to the private subnets, and the Load Balancer will automatically distribute traffic.

- **Manageability**:
   - The Bastion Host allows secure administration of the private instances without exposing them directly to the internet.

## Getting Started

### 1. **Install Terraform**
   - Download and install Terraform from [Terraform Downloads](https://www.terraform.io/downloads).

### 2. **Configure Cloud Provider Credentials**
   - Ensure your AWS credentials are properly configured on your machine.

### 3. **Review Terraform Code**
   - Review the Terraform modules and configuration files to understand how each component is deployed.

### 4. **Set Variables**
   - Edit `terraform.tfvars` with appropriate values, such as project name, AMI ID, and instance types.

### 5. **Initialize Terraform**
   - Run `terraform init` to initialize the Terraform project.

### 6. **Plan the Infrastructure**
   - Run `terraform plan` to preview the infrastructure changes.

### 7. **Deploy the Infrastructure**
   - Run `terraform apply` to create the infrastructure on AWS.

## Shots
![Screenshot 2](https://github.com/mohamedesmael10/terraform-aws-project/raw/main/Shots/2.png)
![Screenshot 3](https://github.com/mohamedesmael10/terraform-aws-project/raw/main/Shots/3.png)
![Screenshot 4](https://github.com/mohamedesmael10/terraform-aws-project/raw/main/Shots/4.png)
![Screenshot 5](https://github.com/mohamedesmael10/terraform-aws-project/raw/main/Shots/5.png)
![Screenshot 6](https://github.com/mohamedesmael10/terraform-aws-project/raw/main/Shots/6.png)
![Screenshot 7](https://github.com/mohamedesmael10/terraform-aws-project/raw/main/Shots/7.png)
![Screenshot 8](https://github.com/mohamedesmael10/terraform-aws-project/raw/main/Shots/8.png)

## Conclusion

This setup provides a highly secure, scalable, and efficient cloud environment. By leveraging AWS services such as EC2, VPC, NAT Gateway, and Load Balancer, the project ensures high availability and fault tolerance for web applications, while keeping sensitive instances protected in private subnets.

### Notes:
- Follow security best practices such as strong passwords and proper access controls.
- Customize the setup to meet your specific project requirements.
