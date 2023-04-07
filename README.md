```
.
├── docker
│   └── docker-compose.yml
├── modelo.png
├── mvnw
├── mvnw.cmd
├── pom.xml
├── Readme.md
└── src
    ├── main
    │   ├── java
    │   │   └── arquitetura
    │   │       └── spring
    │   │           └── hexagonal
    │   │               ├── adapters
    │   │               │   ├── inbound
    │   │               │   │   ├── entity
    │   │               │   │   │   ├── EnderecoEntity.java
    │   │               │   │   │   └── UsuarioEntity.java
    │   │               │   │   ├── mapper
    │   │               │   │   │   ├── EnderecoToEnderecoEntityMapper.java
    │   │               │   │   │   ├── UsuarioEntityToUsuarioMapper.java
    │   │               │   │   │   ├── UsuarioRequestToUsuarioMapper.java
    │   │               │   │   │   └── UsuarioToUsuarioEntityMapper.java
    │   │               │   │   ├── request
    │   │               │   │   │   └── UsuarioRequest.java
    │   │               │   │   └── UsuarioController.java
    │   │               │   └── outbound
    │   │               │       ├── BuscarEnderecoAdapter.java
    │   │               │       ├── repository
    │   │               │       │   └── UsuarioRepository.java
    │   │               │       ├── rest
    │   │               │       │   └── BuscarEnderecoRest.java
    │   │               │       └── SalvarUsuarioAdapter.java
    │   │               ├── application
    │   │               │   ├── core
    │   │               │   │   ├── domain
    │   │               │   │   │   ├── Endereco.java
    │   │               │   │   │   └── Usuario.java
    │   │               │   │   ├── exception
    │   │               │   │   │   └── CoreException.java
    │   │               │   │   └── service
    │   │               │   │       └── SalvarUsuarioService.java
    │   │               │   └── ports
    │   │               │       ├── in
    │   │               │       │   └── SalvarUsuarioServicePort.java
    │   │               │       └── out
    │   │               │           ├── BuscarEnderecoPort.java
    │   │               │           └── SalvarUsuarioPort.java
    │   │               ├── config
    │   │               │   └── Config.java
    │   │               └── HexagonalApplication.java
    │   └── resources
    │       └── application.properties
    └── test
        └── java
            └── arquitetura
                └── spring
                    └── hexagonal
                        └── HexagonalApplicationTests.java


```