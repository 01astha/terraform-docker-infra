# Terraform + Docker Infrastructure Project

## Overview
This project demonstrates Infrastructure as Code (IaC) using Terraform
to provision and manage a local Docker-based application stack.

The goal is to showcase Terraform fundamentals without relying on
cloud providers, making the project easy to run, test, and review.

## Architecture
- Docker Network
- PostgreSQL database with persistent volume
- Backend application container
- Nginx web server exposed on localhost

## Technologies Used
- Terraform (Open Source)
- Docker
- PostgreSQL
- Nginx

## Prerequisites
- Docker Desktop installed and running
- Terraform >= 1.x
- Git

## How to Run
```bash
terraform init
terraform plan
terraform apply
