#!/bin/bash

# Função para criar classes services
# @global: $DOMAIN_CLASSES
# @global: $SERVICE_PATH
_create_service() {
    # Gerar classes de domain
    for DOMAIN_CLASS in "${DOMAIN_CLASSES[@]}"; do
        CLASS_NAME=$(echo "$DOMAIN_CLASS" | cut -d':' -f1)
        CLASS_FIELDS=$(echo "$DOMAIN_CLASS" | cut -d':' -f2)
        
        local ELEMENT_SAVE="$SERVICE_PATH/Save${CLASS_NAME}Service.java"

        # Gera classe de service para save
        echo "
        package com.${PROJECT_NAME}.app.application.core.service;


        import ${PROJECT_NAME}.app.application.core.domain.${CLASS_NAME};
        import ${PROJECT_NAME}.app.application.ports.in.Save${CLASS_NAME}ServicePort;
        import ${PROJECT_NAME}.app.application.ports.out.Search${CLASS_NAME}Port;
        import ${PROJECT_NAME}.app.application.ports.out.Save${CLASS_NAME}Port;
        
        public class Search${CLASS_NAME}Service implements Search${CLASS_NAME}ServicePort {

            private final Save${CLASS_NAME}Port save${CLASS_NAME}Port;

            private final Search${CLASS_NAME}Port search${CLASS_NAME}Port;


            public Save${CLASS_NAME}Service(Save${CLASS_NAME}Port save${CLASS_NAME}Port, Search${CLASS_NAME}Port search${CLASS_NAME}Port) {
                this.save${CLASS_NAME}Port = save${CLASS_NAME}Port;
                this.search${CLASS_NAME}Port = search${CLASS_NAME}Port;
            }

            @Override
            public ${CLASS_NAME} save${CLASS_NAME}(${CLASS_NAME} ${CLASS_NAME,}, Long id) {

                var ${CLASS_NAME,}Id = search${CLASS_NAME}Port.search(id);
                
                // Validar a busca para salvar
                // ${CLASS_NAME,}.setId(${CLASS_NAME,}Id);

                return search${CLASS_NAME}Port.search(${CLASS_NAME,});
            }
        }
        " >> "$ELEMENT_SAVE"

    done
}