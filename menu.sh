#!/bin/bash

HOME_DIR="$HOME/EPNro1"

while true
do
  echo "Hola te damos la bienvenida al ejercicio practico de bash/nTe presentamos nuestro menu de opciones"
  echo "1) Crear entorno"
  echo "2) Correr proceso"
  echo "3) Listar alumnos por numero de padron"
  echo "4) Top 10 notas mas altas"
  echo "5) Buscar datos del alumno"
  echo "6) Salir"

  read opcion

  case $opcion in

  1)
    mkdir -p "$HOME_DIR/entrada"
    mkdir -p "$HOME_DIR/salida"
    mkdir -p "$HOME_DIR/procesado"
    echo "Entorno creado"
  ;;

  2)
    if [ -z "$FILENAME" ]; then
      echo "Error: definir FILENAME"
      echo "Ej: export FILENAME=alumnos"
    else
      sh consolidar.sh &
      echo "Proceso corriendo en background"
    fi
  ;;

  3)
    ARCHIVO="$HOME_DIR/salida/$FILENAME.txt"

    if [ ! -f "$ARCHIVO" ]; then
      echo "No existe archivo"
    else
      sort -n "$ARCHIVO"
    fi
  ;;

  4)
    ARCHIVO="$HOME_DIR/salida/$FILENAME.txt"

    if [ ! -f "$ARCHIVO" ]; then
      echo "No existe archivo"
    else
      sort -k4 -nr "$ARCHIVO" | head -10
    fi
  ;;

  5)
    ARCHIVO="$HOME_DIR/salida/$FILENAME.txt"

    if [ ! -f "$ARCHIVO" ]; then
      echo "No existe archivo"
    else
      echo "Ingrese padron:"
      read padron
      grep "^$padron " "$ARCHIVO"
    fi
  ;;

  6)
    echo "Fin del programa"
    exit 0
  ;;

  *)
    echo "Opcion invalida"
  ;;

  esac

done
