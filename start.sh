#!/bin/bash

# Carrega as constantes do projeto
source config/classes_template.sh
source config/directories_path.sh
# Banner do projeto
source utils/painel.sh
# Funcao para criar diretorios
source utils/mk.sh
# Cria classes
source modules/create_content_file/create_content_entity.sh

# Titulo do programa
_print_painel

# Criação de diretórios
_create_directory "$INBOUND_PATH"
_create_directory "$ENTITY_PATH"
_create_directory "$MAPPER_PATH"
_create_directory "$REQUEST_PATH"
_create_directory "$OUTBOUND_PATH"
_create_directory "$REPOSITORY_PATH"
_create_directory "$REST_PATH"
_create_directory "$DOMAIN_PATH"
_create_directory "$EXCEPTION_PATH"
_create_directory "$SERVICE_PATH"
_create_directory "$IN_PATH"
_create_directory "$OUT_PATH"
_create_directory "$CONFIG_PATH"
_create_directory "$RESOURCES"

# Cria classes
_create_entity