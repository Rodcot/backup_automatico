#!/bin/bash

#diretório de destino do backup
backup_dir="/caminho/para/destino/do/backup"

#arquivo de configuração com a lista de arquivos para backup
arquivos_config="arquivos_para_backup.txt"

#intervalo de tempo para o backup (em segundos)
intervalo_tempo=86400  # 24 horas

while true; do
  #verificando se o arquivo de configuração existe
  if [ ! -e "$arquivos_config" ]; then
    echo "O arquivo de configuração '$arquivos_config' não foi encontrado."
    exit 1
  fi

  #criando um diretório de backup com data e hora atual
  data_hora=$(date +"%Y%m%d%H%M%S")
  pasta_backup="$backup_dir/backup_$data_hora"
  mkdir -p "$pasta_backup"

  #fazendo o backup dos arquivos listados no arquivo de configuração
  while IFS= read -r linha; do
    if [ -e "$linha" ]; then
      cp -r "$linha" "$pasta_backup/"
      echo "Backup de '$linha' concluído."
    else
      echo "Atenção: '$linha' não foi encontrado e não foi incluído no backup."
    fi
  done < "$arquivos_config"

  echo "Backup concluído em $data_hora."

  #aguardando o intervalo de tempo antes do próximo backup
  sleep "$intervalo_tempo"
done
