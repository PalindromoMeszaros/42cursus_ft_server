# 42Madrid School ft_server project
### Mandatory: Score 100/100
***
### Challenge
**Subject** *This project is intended to introduce you to the basics of system and network administration. It will allow you to install a complete web server, using a deployment technology named Docker. This server will run multiples services: Wordpress, phpMyAdmin, and a SQL database*

The web server is deployed in only one docker container which OS is Debian buster. It starts on the wordpress index page and uses SSL protocol.
A Dockerfile and the neccesary configuration files are included for creating a Docker image.
The Docker image would include:
- Nginx
- PHP 7.3
- MariaDB SQL database
- PHPMyAdmin
- Wordpress (latest version)

| Service        | Path                          |
| ---------------| ----------------------------- |
| Wordpress site | `http://localhost`            | 
| PhpMyAdmin     | `http://localhost/phpmyadmin` |

For executing the docker image you must run `docker run -it -p 80:80 -p 443:443 image_name`
