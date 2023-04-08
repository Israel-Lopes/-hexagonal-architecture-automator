#!/bin/bash

# Função para criar classes services
# @global: $DOMAIN_CLASSES
# @global: $SERVICE_PATH
_create_service() {
    # Gerar classes de domain
    for DOMAIN_CLASS in "${DOMAIN_CLASSES[@]}"; do
        CLASS_NAME=$(echo "$DOMAIN_CLASS" | cut -d':' -f1)
        CLASS_FIELDS=$(echo "$DOMAIN_CLASS" | cut -d':' -f2)
        
        # Gera classe de service para save
        local ELEMENT_SAVE="$SERVICE_PATH/Save${CLASS_NAME}Service.java"
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
        
        // Implementar validacao de busca, antes que salve.
        ${CLASS_NAME,}.setId(${CLASS_NAME,}Id);

        return search${CLASS_NAME}Port.search(${CLASS_NAME,});
    }
}
        " >> "$ELEMENT_SAVE"


        # Gera classe de service para busca
        local ELEMENT_SEARCH="$SERVICE_PATH/Search${CLASS_NAME}Service.java"

        echo "
package com.${PROJECT_NAME}.app.application.core.service;

import ${PROJECT_NAME}.app.application.core.domain.${CLASS_NAME};
import ${PROJECT_NAME}.app.application.ports.out.Search${CLASS_NAME}Port;

public class Search${CLASS_NAME}Service implements Search${CLASS_NAME}ServicePort {

    private final Search${CLASS_NAME}Port search${CLASS_NAME}Port;

    public Search${CLASS_NAME}Service(Search${CLASS_NAME}Port search${CLASS_NAME}Port) {
        this.search${CLASS_NAME}Port = search${CLASS_NAME}Port;
    }

    @Override
    public ${CLASS_NAME} search${CLASS_NAME}(${CLASS_NAME} ${CLASS_NAME,}, Long id) {

        var ${CLASS_NAME,}Id = search${CLASS_NAME}Port.search(id);
        
        // Validar a busca
        ${CLASS_NAME,}.setId(${CLASS_NAME,}Id);

        return search${CLASS_NAME}Port.search(${CLASS_NAME,});
    }
}
        " >> "$ELEMENT_SEARCH"


# Gera classe de service para buscar todos
        local ELEMENT_SEARCH_ALL="$SERVICE_PATH/SearchAll${CLASS_NAME}Service.java"

        echo "
package com.${PROJECT_NAME}.app.application.core.service;

import ${PROJECT_NAME}.app.application.core.domain.${CLASS_NAME};
import ${PROJECT_NAME}.app.application.ports.out.SearchAll${CLASS_NAME}Port;

public class SearchAll${CLASS_NAME}Service implements SearchAll${CLASS_NAME}ServicePort {

    private final SearchAll${CLASS_NAME}Port searchAll${CLASS_NAME}Port;

    public SearchAll${CLASS_NAME}Service(SearchAll${CLASS_NAME}Port searchAll${CLASS_NAME}Port) {
        this.searchAll${CLASS_NAME}Port = searchAll${CLASS_NAME}Port;
    }

    @Override
    public ${CLASS_NAME} all${CLASS_NAME}(${CLASS_NAME} ${CLASS_NAME,}, Long id) {

        var ${CLASS_NAME,}All = searchAll${CLASS_NAME}Port.searchAll(id);
        
        // Validar a busca
        ${CLASS_NAME,}.setId(${CLASS_NAME,}All);

        return searchAll${CLASS_NAME}Port.searchAll(${CLASS_NAME,});
    }
}
        " >> "$ELEMENT_SEARCH_ALL"


        # Gera classe de service para criar
        local ELEMENT_CREATE="$SERVICE_PATH/Create${CLASS_NAME}Service.java"

        echo "
package com.${PROJECT_NAME}.app.application.core.service;

import ${PROJECT_NAME}.app.application.core.domain.${CLASS_NAME};
import ${PROJECT_NAME}.app.application.ports.out.Create${CLASS_NAME}Port;

public class Create${CLASS_NAME}Service implements Create${CLASS_NAME}ServicePort {

    private final Create${CLASS_NAME}Port create${CLASS_NAME}Port;

    public Create${CLASS_NAME}Service(Create${CLASS_NAME}Port create${CLASS_NAME}Port) {
        this.create${CLASS_NAME}Port = create${CLASS_NAME}Port;
    }

    @Override
    public ${CLASS_NAME} create${CLASS_NAME}(${CLASS_NAME} ${CLASS_NAME,}) {

        var ${CLASS_NAME,}create = create${CLASS_NAME}Port.create(id);
        
        // Validar criacao e fazer o set dos campos de ${CLASS_NAME} 

        return create${CLASS_NAME}Port.create(${CLASS_NAME,});
    }
}
        " >> "$ELEMENT_CREATE"


        # Gera classe de service para atualizar
        local ELEMENT_UPDATE="$SERVICE_PATH/Create${CLASS_NAME}Service.java"

        echo "
package com.${PROJECT_NAME}.app.application.core.service;

import ${PROJECT_NAME}.app.application.core.domain.${CLASS_NAME};
import ${PROJECT_NAME}.app.application.ports.out.Update${CLASS_NAME}Port;

public class Update${CLASS_NAME}Service implements Update${CLASS_NAME}ServicePort {

    private final Update${CLASS_NAME}Port update${CLASS_NAME}Port;

    public Update${CLASS_NAME}Service(Update${CLASS_NAME}Port update${CLASS_NAME}Port) {
        this.update${CLASS_NAME}Port = update${CLASS_NAME}Port;
    }

    @Override
    public ${CLASS_NAME} update${CLASS_NAME}(${CLASS_NAME} ${CLASS_NAME,}) {

        var ${CLASS_NAME,}update = update${CLASS_NAME}Port.update(id);
        
        // Validar update e fazer o set dos campos de ${CLASS_NAME} 

        return update${CLASS_NAME}Port.update(${CLASS_NAME,});
    }
}
        " >> "$ELEMENT_UPDATE"
        

        # Gera classe de service para deletar
        local ELEMENT_DELETE="$SERVICE_PATH/Delete${CLASS_NAME}Service.java"

        echo "
package com.${PROJECT_NAME}.app.application.core.service;

import ${PROJECT_NAME}.app.application.core.domain.${CLASS_NAME};
import ${PROJECT_NAME}.app.application.ports.out.Delete${CLASS_NAME}Port;

public class Delete${CLASS_NAME}Service implements Delete${CLASS_NAME}ServicePort {

    private final Delete${CLASS_NAME}Port Delete${CLASS_NAME}Port;

    public Delete${CLASS_NAME}Service(Delete${CLASS_NAME}Port delete${CLASS_NAME}Port) {
        this.delete${CLASS_NAME}Port = create${CLASS_NAME}Port;
    }

    @Override
    public ${CLASS_NAME} delete${CLASS_NAME}(${CLASS_NAME} ${CLASS_NAME,}, Long id) {

        var ${CLASS_NAME,}delete = delete${CLASS_NAME}Port.delete(id);
        
        // Validar delete de ${CLASS_NAME} 

        return delete${CLASS_NAME}Port.delete(${CLASS_NAME,});
    }
}
        " >> "$ELEMENT_DELETE"
    done
}