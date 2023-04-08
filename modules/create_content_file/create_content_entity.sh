#!/bin/bash

# Função para criar classes
# @global: $DOMAIN_CLASSES
# @global: $ENTITY_PATH
_create_entity() {
    # Gerar classes de entidades
    for DOMAIN_CLASS in "${DOMAIN_CLASSES[@]}"; do
        CLASS_NAME=$(echo "$DOMAIN_CLASS" | cut -d':' -f1)
        CLASS_FIELDS=$(echo "$DOMAIN_CLASS" | cut -d':' -f2)
        
        local ELEMENT="$ENTITY_PATH/${CLASS_NAME}Entity.java"

        # Gerar classe de entidade
        echo "package com.${PROJECT_NAME}.app.persistence.entity;" >> "$ELEMENT"
        echo "" >> "$ELEMENT"
        echo "import javax.persistence.Entity;" >> "$ELEMENT"
        echo "import javax.persistence.GeneratedValue;" >> "$ELEMENT"
        echo "import javax.persistence.GenerationType;" >> "$ELEMENT"
        echo "import javax.persistence.Id;" >> "$ELEMENT"
        echo "import javax.persistence.Table;" >> "$ELEMENT"
        echo "import lombok.AllArgsConstructor;" >> "$ELEMENT"
        echo "import lombok.Builder;" >> "$ELEMENT"
        echo "import lombok.Data;" >> "$ELEMENT"
        echo "import lombok.NoArgsConstructor;" >> "$ELEMENT"
        echo "" >> "$ELEMENT"
        echo "import java.util.List;" >> "$ELEMENT"

        echo "" >> "$ELEMENT"
        echo "@Entity" >> "$ELEMENT"
        echo "@Table(name=\"${CLASS_NAME,}\")" >> "$ELEMENT"
        echo "@Data" >> "$ELEMENT"
        echo "@Builder" >> "$ELEMENT"
        echo "@AllArgsConstructor" >> "$ELEMENT"
        echo "@NoArgsConstructor" >> "$ELEMENT"
        echo "public class ${CLASS_NAME}Entity {" >> "$ELEMENT"

        echo "" >> "$ELEMENT"
        IFS=',' read -ra FIELDS <<< "$CLASS_FIELDS"
        for FIELD in "${FIELDS[@]}"; do
            FIELD_NAME=$(echo "$FIELD" | cut -d'=' -f1)
            FIELD_TYPE=$(echo "$FIELD" | cut -d'=' -f2)

            # Adiciona o sufixo Entity ao tipo do campo, caso ele corresponda 
            # a uma classe em DOMAIN_CLASSES
            for DOMAIN_CLASS2 in "${DOMAIN_CLASSES[@]}"; do
                CLASS_NAME2=$(echo "$DOMAIN_CLASS2" | cut -d':' -f1)
            if [[ "$FIELD_TYPE" == "$CLASS_NAME2" ]]; then
                FIELD_TYPE="${CLASS_NAME2}Entity"
                break
            elif [[ "$FIELD_TYPE" == *"<$CLASS_NAME2>"* ]]; then
                INNER_TYPE=$(echo "$FIELD_TYPE" | sed -r 's/.*<(.*)>/\1/')
                for DOMAIN_CLASS3 in "${DOMAIN_CLASSES[@]}"; do
                CLASS_NAME3=$(echo "$DOMAIN_CLASS3" | cut -d':' -f1)
                if [[ "$INNER_TYPE" == "$CLASS_NAME3" ]]; then
                    FIELD_TYPE=$(echo "$FIELD_TYPE" | sed -r "s/<$INNER_TYPE>/<${CLASS_NAME3}Entity>/")
                    break
                fi
                done
                break
            fi
            done

            echo "  private $FIELD_TYPE $FIELD_NAME;" >> "$ELEMENT"
        done
    
        echo "}" >> "$ELEMENT"

        _progress_bar "$total_progress" "$current_progress"
        sleep 0.1
        current_progress=$(( (current_progress + 1) % (total_progress + 1) ))
    done
}