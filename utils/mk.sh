#!/bin/bash

# Função para criar diretórios
_create_directory() {
  mkdir -p "$1"
  mkdir -p "${2:-./}"
}