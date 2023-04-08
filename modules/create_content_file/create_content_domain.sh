#!/bin/bash

# Função para criar classes domain
# @global: $DOMAIN_CLASSES
# @global: $DOMAIN_PATH
_create_domain() {
    # Gerar classes de domain
    for DOMAIN_CLASS in "${DOMAIN_CLASSES[@]}"; do
    CLASS_NAME=$(echo "$DOMAIN_CLASS" | cut -d':' -f1)
    CLASS_FIELDS=$(echo "$DOMAIN_CLASS" | cut -d':' -f2)
    
    local ELEMENT="$DOMAIN_PATH/${CLASS_NAME}.java"

    # Gerar classe de entidade
    echo "package com.${PROJECT_NAME}.app.application.core.domain;" >> "$ELEMENT"
    echo "" >> "$ELEMENT"
    echo "import java.util.List;" >> "$ELEMENT"
    echo "" >> "$ELEMENT"

    echo "public class ${CLASS_NAME} {" >> "$ELEMENT"
    echo "" >> "$ELEMENT"
    IFS=',' read -ra FIELDS <<< "$CLASS_FIELDS"
    for FIELD in "${FIELDS[@]}"; do
        FIELD_NAME=$(echo "$FIELD" | cut -d'=' -f1)
        FIELD_TYPE=$(echo "$FIELD" | cut -d'=' -f2)

        echo "  private $FIELD_TYPE $FIELD_NAME;" >> "$ELEMENT"
    done

    # Gera metodos Getter e Setter
    for FIELD in "${FIELDS[@]}"; do
        FIELD_NAME=$(echo "$FIELD" | cut -d'=' -f1)
        FIELD_TYPE=$(echo "$FIELD" | cut -d'=' -f2)
        # Gerar método get
        echo "" >> "$ELEMENT"
        echo "  public $FIELD_TYPE get${FIELD_NAME^}() {" >> "$ELEMENT"
        echo "    return this.$FIELD_NAME;" >> "$ELEMENT"
        echo "  }" >> "$ELEMENT"
        # Gerar método set
        echo "" >> "$ELEMENT"
        echo "  public void set${FIELD_NAME^}($FIELD_TYPE $FIELD_NAME) {" >> "$ELEMENT"
        echo "    this.$FIELD_NAME = $FIELD_NAME;" >> "$ELEMENT"
        echo "  }" >> "$ELEMENT"
    done

    # Gerar método toString
    echo "" >> "$ELEMENT"
    echo "  @Override" >> "$ELEMENT"
    echo "  public String toString() {" >> "$ELEMENT"
    echo "    return \"${CLASS_NAME}{\" +" >> "$ELEMENT"
    for FIELD in "${FIELDS[@]}"; do
        FIELD_NAME=$(echo "$FIELD" | cut -d'=' -f1)

        echo "      \"$FIELD_NAME=\" + $FIELD_NAME +" >> "$ELEMENT"
    done
    echo "      \"}\";" >> "$ELEMENT"
    echo "  }" >> "$ELEMENT"
    echo "}" >> "$ELEMENT"
    done

    _progress_bar "$total_progress" "$current_progress"
    sleep 0.1
    current_progress=$(( (current_progress + 1) % (total_progress + 1) ))
}