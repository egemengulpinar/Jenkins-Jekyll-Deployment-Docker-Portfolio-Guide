# Jenkins-Jekyll-Docker-Portfolio-Guide


This repo contains the start-to-end development process and answers how to create basic **portfolio deployment, server settings, CI/CD configurations, remote connections, dockerize project, SSL certifications and domains settings**, 

I really understand the basics of web development processes when I started to create this documentation and took some notes. I believe some of you will get it easily from this documentation. Repo shows every answer step by step and also I added language support for understanding easily for kind of other developers. 


## Table of Contents


- [Create Portfolio](#create-portfolio)
- [Server Port Settings](#server-port-settings)
- [Mac and Windows SSH Connection](#mac-and-windows-ssh-connection)
  - [Windows SSH Connection](#windows-ssh-connection)
  - [Mac SSH Connection](#mac-ssh-connection)
- [Download and Install Dependencies](#download-and-install-dependencies)
  - [Packages](#packages)
  - [Docker](#docker)
- [Create Docker Image](#create-docker-image)
- [Domain](#domain)
- [DNS Configuration and SSL Certification](#dns-configuration-and-ssl-certification)
- [CI-CD](#ci-cd)
- [References](#references)


## Create Portfolio
You can use what ever want for create your own portfolio. But I can give a simple way. I decided to use **Jekyll** because Jekyll is a simple, blog-aware, static site generator for creating a personal website, portfolio or blog. Based on Jekyll I would like to share [Al Folio](https://github.com/alshedivat/al-folio) that uses for simple academics page but I customized it for what I decided to use.
You can use either the same customized template, just edit **src** folder and read the instructions of al-folio.


## Server Port Settings
Before starting the main server configurations, check your servers port settings. Be sure that your preferred ports to use are open and can be used. There is an example of that. (If you are using Oracle Cloud Servers, follow ***Networking->Virtual cloud networks->YOUR_NETWORK_NAME -> Security List Details***)

![ports](https://github.com/egemengulpinar/egemengulpinar.com/assets/71253469/9cea46ad-cf8b-41ac-9574-b42eae6e7f3a)


## Mac and Windows SSH Connection

Before making the platform-based settings you need to create your private & public key. Generate it with the following code:
```sh
ssh-keygen -t rsa -N "passphrase" -b 2048 -C "oracle" -f ./
```



Please refer to the image below for understanding the ssh line.

![image](https://github.com/egemengulpinar/egemengulpinar.com/assets/71253469/2e2d5733-434d-496b-9c41-27a9cb5ca18e)

### Windows SSH Connection
You can just use `PuttY` for connecting the remote server via ssh like below.

![image](https://github.com/egemengulpinar/egemengulpinar.com/assets/71253469/09e03728-0a4b-4e01-b076-9715309f1f79)


For connecting the remote server just run the below line
```sh
ssh username@ipAddress
```

After your successful connection, clone your `portfolio repo`
```sh
sudo su
git clone https://github.com/YOUR_REPO_LINK
```

### Mac SSH Connection

You can just use `terminal` for connecting the remote server via ssh

For connecting the remote server just run the below line
```sh
ssh username@ipAddress
```

**Note** If Mac users have connection problems, please check the below files and change them with your previous public & private key files.

<img width="1140" alt="image" src="https://github.com/egemengulpinar/egemengulpinar.com/assets/71253469/2b3cafdc-dbec-45d5-b268-cdf835dae655">



After your successful connection, clone your `portfolio repo`
```sh
sudo su
git clone https://github.com/YOUR_REPO_LINK
```

## Download and Install Dependencies
Run these lines and wait just couple of minutes

### Packages
Install required packages
```sh
 sudo apt-get update
 sudo apt-get install ca-certificates curl gnupg
```

### Docker
Please refer to the up-to-date docker installation page. Follow each step and make sure `sudo docker run hello-world` is working properly.
Then, you need to set up your `dockerfile`. I just used ultra-basic steps for creating my portfolio.

```sh
FROM nginx:latest
COPY src/_site /usr/share/nginx/html
```
I used nginx for create a basic web-server, You can use other web-servers as well. `/usr/share/nginx/html` that folder contains your portfolio site main source code. It will run and render in this location of nginx.
Save the above code to `Dockerfile` and save it into your repo. After you can clone it again to update the changes on server.

## Create Docker Image
Let's talk about **Build your own docker image & run**, you should just follow basic 2 lines to create your docker image & container.
```sh
docker build -t <YOUR_IMAGE_NAME> .
docker run -it --rm -d -p 80:80 --name <YOUR_CONTAINER_NAME> <YOUR_IMAGE_NAME>
```

After checking everything works properly by enter to the browser your server's public address
`198.XXX.XX.XX`
You should see your page and render successfully. 

## Domain


You might not want to use your server's public ID address. That's why we use DNS and Domain! First, you need to take a unique domain from `Google Domains`,  `GoDaddy`  or a relevant provider. After that, do not close your domain page we will turn it back in the next section.

## DNS Configuration and SSL Certification
First, you need to take your SSL certificate for secure `HTTPS` forwarding on your page. Create an account on `Cloudflare` and get your free SSL certificate like below. Just Click `SSL/TLS` and follow the instructions, it should look like below:

<img width="1367" alt="image" src="https://github.com/egemengulpinar/egemengulpinar.com/assets/71253469/1212bf5f-a426-40be-8707-03e392f78a41">

After you should create DNS settings on the same page. Click `DNS` then `Add record`. Write your Public IP Address in the `Content` column, also write your desired domain address in the `Name` column.

<img width="1102" alt="Ekran Resmi 2023-07-14 22 27 19" src="https://github.com/egemengulpinar/egemengulpinar.com/assets/71253469/fc159fc7-9957-4f04-8b0e-30d903db387d">


At the below of the page, you can see these two `nameservers`, quickly copy them!

<img width="1088" alt="image" src="https://github.com/egemengulpinar/egemengulpinar.com/assets/71253469/762d7b45-6aa2-44c9-ae23-f08c2166f552">


You should forward your domain to your IP address, that's what we called DNS. In your domain provider, go to your `DNS` tab and change the below settings (I used Google Domains but other providers have the same page don't worry)
Now, paste your `nameservers` into this field. Do not use **Default name servers**. 

<img width="1229" alt="image" src="https://github.com/egemengulpinar/egemengulpinar.com/assets/71253469/2a8be740-78b0-4f41-82f0-6d06a648247a">


## CI-CD 

This part is my favourite part because I like using `Jenkins`, it is so simple and effective. 
For refer to strong documentation for Jenkins on Linux, please check this [documentation](https://www.jenkins.io/doc/book/installing/linux/#debianubuntu)
First, you need to install Java SDK on Linux.
```sh
$ sudo apt update
$ sudo apt install openjdk-11-jre
$ java -version
openjdk version "11.0.12" 2021-07-20
OpenJDK Runtime Environment (build 11.0.12+7-post-Debian-2)
OpenJDK 64-Bit Server VM (build 11.0.12+7-post-Debian-2, mixed mode, sharing)
```

After, run each code below step-by-step
```sh
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

### ###

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

### ###

sudo apt-get update
sudo apt-get install jenkins
```

After you can check which port is using? other status and info  with this command 

```sh
sudo systemctl status jenkins
```

if you want to change the jenkins port, change this code section
```sh
systemctl edit jenkins
then,
[Service]
Environment="JENKINS_PORT=8081"
```

For default settings, `Jenkins` run on the `localhost:8080` port. NowyYou just open your browser and write your public ip address with `8080` port. It should be like that: `192.145.13.21:8080`  then you can display Jenkins welcome page like below.

![image](https://github.com/egemengulpinar/egemengulpinar.com/assets/71253469/0237a8c5-f6e5-4df5-90f1-1b3c1e800c7d)

Please follow the steps and create your jenkins account. After, in `Control Center`, click `new job` and select `Configure a freestyle project` and give your project a name. After follow the below steps:

![image](https://github.com/egemengulpinar/egemengulpinar.com/assets/71253469/8e3311a0-5167-4961-9b4a-d282f332572c)

Enter your GitHub credentials like below. Do not forget. If your project head branch name like "production" you should write it on the **Branch Specifier** line.
![image](https://github.com/egemengulpinar/egemengulpinar.com/assets/71253469/48a00f4f-c0b4-4b58-9d02-3e04d110b507)

In the **Build Triggers** section I have selected `Poll SCM`, you can choose `GitHub hook trigger` as well. That's your choice, just follow the documentation. 

`* * * * *` means it checks every minute but it is not recommended. I generally use `H/15 * * * *`  checks every 15 minutes to deploy

![image](https://github.com/egemengulpinar/egemengulpinar.com/assets/71253469/5f958911-25a2-499e-95dd-9b3d1baf624b)

And final, `configuration environment` section is the most important part for us. Jenkins checks every 15 minutes and if any commits are passed, it will start to run your commands. I have selected `shell script` for that. It just creates my docker image again, it's fit for me.
```sh
#!/bin/bash

# Set container and image names as variables
container_name="YOUR_CONTAINER_NAME"
image_name="YOUR_IMAGE_NAME:1.0.0"

# Check if the container exists
container_exists=$(docker ps -a --filter "name=${container_name}" --format "{{.Names}}")

# Stop and remove the existing container if it exists
if [ "$container_exists" == "${container_name}" ]; then
    docker stop ${container_name}
    docker rm ${container_name}
    docker rmi ${image_name} --force
fi

# Run the new container

docker build -t image_name .
docker run -it -d -p 80:80 --name ${container_name}  imagename:1.0.0

```
For the rest of the part, just click save & apply. You can test it via `Configure Now` button on the left side.

That's it, well done!

## References
[Jenkins Installation on Linux]('https://www.jenkins.io/doc/book/installing/linux/#debianubuntu')
[How to Use Jenkins Docker Image]('https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/')
[Jenkins Official Image]('https://hub.docker.com/_/nginx')
[Install Docker Engine on Ubuntu]('https://docs.docker.com/engine/install/ubuntu/')


