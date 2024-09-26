FROM ubuntu:latest

USER root

RUN apt-get update && apt install fortune-mod cowsay -y

WORKDIR /usr/src/app

COPY wisecow.sh .

RUN chmod +x wisecow.sh

CMD ["./wisecow.sh" ]

EXPOSE 4499
