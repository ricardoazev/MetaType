#!/bin/bash
SEARCH="lynx"
ALVO="$1"
TYPO="$2"
echo "  __  __            _       _     _       _   _       _     "
echo " |  \/  |          (_)     | |   (_)     | | (_)     (_)    "
echo " | \  / | _____   ___  __ _| |__  _  __ | |_ _  __ _ _ ___ "
echo " | |\/| |/ _ \ \ / / |/ _' | '_ \| |/ / | __| |/ _' | / __|"
echo " | |  | |  __/\ V /| | (_| | | | |   <  | |_| | (_| | \__ \\"
echo " |_|  |_|\___| \_/ |_|\__, |_| |_|_|\_\  \__|_|\__, |_|___/"
echo "                        __/ |                  __/ |      "
echo "                       |___/                  |___/       "
echo " Bem-vindo à aplicação MeTaArquIvO!"
echo "Dev - Ricardo"

echo "=========Coleta de ArquivoS==================="
# Realiza a pesquisa com lynx e filtra os URLs dos arquivos PDF
URLS=$($SEARCH --dump "https://google.com/search?&q=site:$ALVO+ext:$TYPO" | grep ".pdf" | cut -d "=" -f2 | egrep -v "site|google" | sed 's/...$//')

# Loop sobre os URLs encontrados
for URL in $URLS; do
    # Baixa o arquivo PDF
    wget -q "$URL" -O temp.pdf
    
    # Extrai os metadados usando exiftool
    exiftool temp.pdf
    
    # Remove o arquivo temporário
    rm temp.pdf
echo "========Coleta de Metadados concluida=========="
done 

