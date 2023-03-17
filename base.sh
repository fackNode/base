#!/bin/bash

curl -s "https://nodes.fackblock.com/api/logo.sh" | sh && sleep 2

fmt=`tput setaf 45`
end="\e[0m\n"
err="\e[31m"
scss="\e[32m"

if [ ! $ethRpc ]; then
	echo -e "${err}You don't RPC variable! / Нет переменной RPC! ${end}" && sleep 1
    exit 1

else
    echo -e "${fmt}Your node name - ${NIBIRU_NAME} ${end}" && sleep 1
fi

sudo apt update
sudo apt install ufw

wget https://raw.githubusercontent.com/fackNode/requirements/main/docker.sh && chmod +x docker.sh && ./docker.sh

git clone https://github.com/base-org/node.git
cd $HOME/node

sed -i 's#- OP_NODE_L1_ETH_RPC=https://ethereum-goerli-rpc.allthatnode.com#- OP_NODE_L1_ETH_RPC=$ethRpc#g' docker-compose.yml

docker-compose up -d

if docker ps -a | grep -q 'node-node-1' && docker ps -a | grep -q 'node-geth-1'; then
  echo -e "${fmt}\nNode installed correctly / Нода установлена корректно${end}" && sleep 1
else
  echo -e "${err}\nNode installed incorrectly / Нода установлена некорректно${end}" && sleep 1
fi
