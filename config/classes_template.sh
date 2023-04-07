#!/bin/bash

# Nome do projeto
readonly PROJECT_NAME="ExemploApp"

# Classes do domínio
readonly DOMAIN_CLASSES=(
  "Cart:id=Long,productList=List<Product>,user=User"
  "Product:id=Long,name=String,description=String,price=Double"
  "User:id=Long,name=String,email=String,password=String"
)

# Descricao do projeto
readonly DESCRIPTION="Projeto de exemplo"