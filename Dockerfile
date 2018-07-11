FROM ubuntu:18.04
RUN apt update && apt install -y sudo build-essential software-properties-common curl git apt-utils
ADD ./ /root/dotfiles/
WORKDIR /root/dotfiles
