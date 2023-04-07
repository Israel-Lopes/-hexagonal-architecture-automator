#!/bin/bash

# Gerar classes de entidades
for DOMAIN_CLASS in "${DOMAIN_CLASSES[@]}"; do
  CLASS_NAME=$(echo "$DOMAIN_CLASS" | cut -d':' -f1)
  CLASS_FIELDS=$(echo "$DOMAIN_CLASS" | cut -d':' -f2)
  
  # Gerar classe de entidade
  echo "Gerando classe de entidade: $ENTITY/${CLASS_NAME}Entity.java" | sed 's/\//./g'
  echo "package com.${PROJECT_NAME}.app.persistence.entity;" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "import javax.persistence.Entity;" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "import javax.persistence.GeneratedValue;" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "import javax.persistence.GenerationType;" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "import javax.persistence.Id;" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "import javax.persistence.Table;" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "import lombok.AllArgsConstructor;" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "import lombok.Builder;" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "import lombok.Data;" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "import lombok.NoArgsConstructor;" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "import java.util.List;" >> "$ENTITY/${CLASS_NAME}Entity.java"

  echo "" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "@Entity" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "@Table(name=\"$CLASS_NAME\")" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "@Data" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "@Builder" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "@AllArgsConstructor" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "@NoArgsConstructor" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "public class ${CLASS_NAME}Entity {" >> "$ENTITY/${CLASS_NAME}Entity.java"

  echo "Gerar atributos da classe"
  echo "" >> "$ENTITY/${CLASS_NAME}Entity.java"
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
      elif [[ "$FIELD_TYPE" == "List<$CLASS_NAME2>"* || "$FIELD_TYPE" == "Collection<$CLASS_NAME2>"* ]]; then
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

    echo "  private $FIELD_TYPE $FIELD_NAME;" >> "$ENTITY/${CLASS_NAME}Entity.java"
  done

  # Gera metodos Getter e Setter
  for FIELD in "${FIELDS[@]}"; do
      FIELD_NAME=$(echo "$FIELD" | cut -d'=' -f1)
      FIELD_TYPE=$(echo "$FIELD" | cut -d'=' -f2)

      # Verificar se o tipo de campo é uma lista
      if [[ "$FIELD_TYPE" == "List"* ]]; then
        # Extrair o tipo de elemento da lista
        ELEMENT_TYPE=$(echo "$FIELD_TYPE" | sed -e 's/^List<//;s/>$//')
        # Adicionar o sufixo "Entity" ao tipo do elemento, se corresponder a uma classe em "DOMAIN_CLASSES"
        for DOMAIN_CLASS2 in "${DOMAIN_CLASSES[@]}"; do
          CLASS_NAME2=$(echo "$DOMAIN_CLASS2" | cut -d':' -f1)
          if [[ "$ELEMENT_TYPE" == "$CLASS_NAME2" ]]; then
            ELEMENT_TYPE="${CLASS_NAME2}Entity"
            break
          fi
        done
        # Construir o tipo de campo com o sufixo "Entity"
        FIELD_TYPE="List<$ELEMENT_TYPE>"
      else
        # Adicionar o sufixo "Entity" ao tipo do campo, se corresponder a uma classe em "DOMAIN_CLASSES"
        for DOMAIN_CLASS2 in "${DOMAIN_CLASSES[@]}"; do
          CLASS_NAME2=$(echo "$DOMAIN_CLASS2" | cut -d':' -f1)
          if [[ "$FIELD_TYPE" == "$CLASS_NAME2" ]]; then
            FIELD_TYPE="${CLASS_NAME2}Entity"
            break
          fi
        done
      fi
      # Gerar método get
      echo "" >> "$ENTITY/${CLASS_NAME}Entity.java"
      echo "  public $FIELD_TYPE get${FIELD_NAME^}() {" >> "$ENTITY/${CLASS_NAME}Entity.java"
      echo "    return this.$FIELD_NAME;" >> "$ENTITY/${CLASS_NAME}Entity.java"
      echo "  }" >> "$ENTITY/${CLASS_NAME}Entity.java"
      # Gerar método set
      echo "" >> "$ENTITY/${CLASS_NAME}Entity.java"
      echo "  public void set${FIELD_NAME^}($FIELD_TYPE $FIELD_NAME) {" >> "$ENTITY/${CLASS_NAME}Entity.java"
      echo "    this.$FIELD_NAME = $FIELD_NAME;" >> "$ENTITY/${CLASS_NAME}Entity.java"
      echo "  }" >> "$ENTITY/${CLASS_NAME}Entity.java"
  done

  # Gerar método toString
  echo "" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "  @Override" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "  public String toString() {" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "    return \"${CLASS_NAME}Entity{\" +" >> "$ENTITY/${CLASS_NAME}Entity.java"
  for FIELD in "${FIELDS[@]}"; do
    FIELD_NAME=$(echo "$FIELD" | cut -d'=' -f1)

    echo "      \"$FIELD_NAME=\" + $FIELD_NAME +" >> "$ENTITY/${CLASS_NAME}Entity.java"
  done
  echo "      \"}\";" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "  }" >> "$ENTITY/${CLASS_NAME}Entity.java"
  echo "}" >> "$ENTITY/${CLASS_NAME}Entity.java"
done