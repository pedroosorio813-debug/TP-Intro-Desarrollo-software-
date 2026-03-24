#!/bin/bash

HOME_DIRECTORIO="$HOME/EPNro1"
ENTRADA_DIR="$HOME_DIRECTORIO/entrada"
SALIDA_DIR="$HOME_DIRECTORIO/salida"
PROCESADO_DIR="$HOME_DIRECTORIO/procesado"

ARCHIVO_SALIDA="$SALIDA_DIR/$FILENAME.txt"

echo "Iniciando consolidación..."

touch "$ARCHIVO_SALIDA"

for archivo in "$ENTRADA_DIR"/*.txt; do
  [ -e "$archivo" ] || continue

  echo "Procesando $archivo"

  cat "$archivo" >> "$ARCHIVO_SALIDA"
  mv "$archivo" "$PROCESADO_DIR/"
done

echo "Proceso terminado."
