# Inception
A Docker-based infrastructure project that sets up a secure web stack with NGINX, WordPress, and MariaDB following specific configuration rules.

## Table of Contents
- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Services](#services)
- [Installation](#installation)
- [Start](#start)



## Project Overview

This project implements a small infrastructure composed of three interconnected services running in Docker containers:
* NGINX with TLS encryption
* WordPress with php-fpm
* MariaDB database

All containers are built from custom Dockerfiles and connected through a dedicated Docker network.


## Architecture

```bash
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   NGINX         │    │   WordPress      │    │   MariaDB       │
│   Container     │◄──►│   Container      │◄──►│   Container     │
│   (TLS Enabled) │    │   (php-fpm)      │    │   (Database)    │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                         ┌───────────────┐
                         │ Docker Network│
                         └───────────────┘
```


## Services

### 1. NGINX Container
* TLSv1.2/TLSv1.3 only
* Custom configuration for WordPress routing
* SSL certificates for secure connections

### 2. WordPress Container
* WordPress with php-fpm (no NGINX)
* Custom configuration and setup
* Connected to MariaDB database

### 3. MariaDB Container
* Database service only (no NGINX)
* Initialized with WordPress database schema
* Two users including a custom administrator account


## Installation

### Prerequisites
* Docker
* Docker Compose
* openssl
* make

### Configuration
Create a env file in the srcs directory
```bash
ROOTUSER=  your root username
ADMINUSER= your admin username
AUTHORUSER= your author username
DOMAINNAME= your domain name (example: test.com)

These values can be whatever you want
```
Create a secrets folder in the root directory. cd to your secrets folder and create 3 files with these names:
* rootpassword.txt
* adminpassword.txt
* authorpassword.txt

Open these txt files and insert these values into the files:
```bash
rootpassword.txt  -> place your root password here
adminpassword.txt  -> place your wordpress admin password here
authorpassword.txt  -> place your wordpress author password here

These values can be whatever you want
```

Now go to your secrets directory (important !!!) and run this command:
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt
```

### Optional

If you want to access your wordpress in your browser with your domain name, 
then you have to add it to your etc/hosts file
```bash
NOTE: X  has to be exactly the same as your DOMAINNAME you used in your env file.

To add the domain name to your hosts
sudo sed -i "/X/d" /etc/hosts && echo "127.0.0.1 X" | sudo tee -a /etc/hosts

To remove the domain name from your hosts
sudo sed -i "/X/d" /etc/hosts

IMPORTANT: Make sure to delete the domain name from your hosts after you are finished.or you won't be able to access that domain name  anymore.

EXAMPLE: if the domain name you used was gitlab.com.You wont be able to access gitlab.com anymore,
since it's linked to the 127.0.0.1 IP-address unless you remove it.
```

## Start

```bash
Go to the root of your directory and run this command:
make
or you can also use this command:
make all

if you are finished use this command: 
make down
```
