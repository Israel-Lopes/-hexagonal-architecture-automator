#!/bin/bash

# Função para exibir barra de progresso animada
progress_bar() {
  local total="$1"
  local progress="$2"
  local bar_length=30
  local bar=""
  local percentage=""
  
  # Calcula o tamanho da barra de progresso e a porcentagem
  local num=$((progress * bar_length / total))
  for ((i=0; i<num; i++)); do
    bar+="="
  done
  for ((i=num; i<bar_length; i++)); do
    bar+=" "
  done
  percentage="$((progress * 100 / total))%"
  
  # Exibe a barra de progresso e a porcentagem
  printf "\r[%s] %s" "$bar" "$percentage"
}

# # Exemplo de uso da função progress_bar()
# total_progress=3
# current_progress=0

# # Loop de animação da barra de progresso
# while true; do
#   progress_bar "$total_progress" "$current_progress"
#   sleep 0.1
#   current_progress=$(( (current_progress + 1) % (total_progress + 1) ))
# done
