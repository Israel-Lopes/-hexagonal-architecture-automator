#!/bin/bash

#Configuracao de diretorios

# inbound
readonly INBOUND_PATH="./hexagonal/src/main/java/app/adapters/inbound"
readonly ENTITY_PATH="./hexagonal/src/main/java/app/adapters/inbound/entity"
readonly MAPPER_PATH="./hexagonal/src/main/java/app/adapters/inbound/mapper"
readonly REQUEST_PATH="./hexagonal/src/main/java/app/adapters/inbound/request"
# outbound
readonly OUTBOUND_PATH="./hexagonal/src/main/java/app/adapters/outbound"
readonly REPOSITORY_PATH="./hexagonal/src/main/java/app/adapters/outbound/repository"
readonly REST_PATH="./hexagonal/src/main/java/app/adapters/outbound/rest"
# core
readonly DOMAIN_PATH="./hexagonal/src/main/java/app/application/core/domain"
readonly EXCEPTION_PATH="./hexagonal/src/main/java/app/application/core/exception"
readonly SERVICE_PATH="./hexagonal/src/main/java/app/application/core/service"
# ports
readonly IN_PATH="./hexagonal/src/main/java/app/application/ports/in"
readonly OUT_PATH="./hexagonal/src/main/java/app/application/ports/out"
# config
readonly CONFIG_PATH="./hexagonal/src/main/java/app/config"
# resources
readonly RESOURCES="./hexagonal/src/main/resources"