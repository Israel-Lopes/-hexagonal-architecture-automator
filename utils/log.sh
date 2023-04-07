#!/bin/bash

# Função para criar banner
_log_created() {
GREEN='\033[0;32m'
NC='\033[0m'
echo -e "${GREEN}
[created]: $1
  ${NC}"
}
