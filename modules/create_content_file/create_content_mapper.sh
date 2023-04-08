#!/bin/bash

# Função para criar mappers
# @global: $DOMAIN_CLASSES
# @global: $MAPPER_PATH
_create_mapper() {
    # Gerar classes de mappers
    for DOMAIN_CLASS in "${DOMAIN_CLASSES[@]}"; do
        CLASS_NAME=$(echo "$DOMAIN_CLASS" | cut -d':' -f1)
        CLASS_FIELDS=$(echo "$DOMAIN_CLASS" | cut -d':' -f2)
        
        # Gerar classe de mapper entity para domain
        local ELEMENT_TO_DOMAIN="$MAPPER_PATH/${CLASS_NAME}EntityTo${CLASS_NAME}Mapper.java"
        echo "
package com.${PROJECT_NAME}.app.adapters.inbound.mapper;

import ${PROJECT_NAME}.app.adapters.inbound.entity.${CLASS_NAME}Entity;
import ${PROJECT_NAME}.app.application.core.domain.${CLASS_NAME};
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class ${CLASS_NAME}EntityTo${CLASS_NAME}Mapper {

     public ${CLASS_NAME} mapper(${CLASS_NAME}Entity ${CLASS_NAME,}Entity){
          var ${CLASS_NAME,} = new ${CLASS_NAME}();
          BeanUtils.copyProperties(${CLASS_NAME,}Entity, ${CLASS_NAME,});
          return ${CLASS_NAME,};
     }

}
" >> "$ELEMENT_TO_DOMAIN"

        # Gerar classe de mapper domain para entity
        local ELEMENT_TO_ENTITY="$MAPPER_PATH/${CLASS_NAME}To${CLASS_NAME}EntityMapper.java"
        echo "
package com.${PROJECT_NAME}.app.adapters.inbound.mapper;

import ${PROJECT_NAME}.app.adapters.inbound.entity.${CLASS_NAME}Entity;
import ${PROJECT_NAME}.app.application.core.domain.${CLASS_NAME};
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class ${CLASS_NAME}To${CLASS_NAME}EntityMapper {
     public ${CLASS_NAME}Entity mapper(${CLASS_NAME} ${CLASS_NAME,}){
          var ${CLASS_NAME,}Entity = new ${CLASS_NAME}Entity();
          BeanUtils.copyProperties(${CLASS_NAME,}, ${CLASS_NAME,}Entity);
          return ${CLASS_NAME,}Entity;
     }

}
" >> "$ELEMENT_TO_ENTITY"

        _progress_bar "$total_progress" "$current_progress"
        sleep 0.1
        current_progress=$(( (current_progress + 1) % (total_progress + 1) ))
    done
}