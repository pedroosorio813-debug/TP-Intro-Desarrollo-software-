#!/bin/bash

while true; do
    shopt -s nullglob
    for archivo in $DIRECTORIO_ENTRADA*; do
        if [ -f "$archivo" ]; then
            cat "$archivo" >> "$DIRECTORIO_SALIDA$FILENAME.txt"
            mv "$archivo" "$DIRECTORIO_PROCESADO"
        fi
    done
    sleep 5  # Espera de 5 segundos antes de repetir el proceso para el manejo de recursos
done