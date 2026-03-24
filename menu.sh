#!/bin/bash

# En caso de que se especifique parámetro '-d', cierra procesos en background y limpia las variables de entorno creadas
if [ "$1" == "-d" ]; then # Las comillas son importantes para que no tire error en caso de que no se especifique el parámetro
    echo "Finalizando proceso 'consolidar.sh'..."
    pkill -f consolidar.sh
    
    echo "Limpiando variables en memoria..."
    unset FILENAME DIRECTORIO_ENTRADA DIRECTORIO_SALIDA DIRECTORIO_PROCESADO
    exit 0
fi

# Creo las variables de los directorios para mayor claridad en las rutas
# A su vez, exporto las variables para emplearlas dentro de consolidar.sh 
export DIRECTORIO_ENTRADA="$HOME/EPNro1/entrada/"
export DIRECTORIO_SALIDA="$HOME/EPNro1/salida/"
export DIRECTORIO_PROCESADO="$HOME/EPNro1/procesado/"

echo -e "Hola! Te damos la bienvenida al Ejercicio Práctico de Bash\nTe presentamos nuestro menú de opciones:"
echo "Opcion 1: Crear Entorno"
echo "Opcion 2: Correr Proceso"
echo "Opcion 3: Listar alumnos ordenados por número de padrón"
echo "Opcion 4: Mostrar las 10 notas más altas"
echo "Opcion 5: Datos de alumno específico"
echo "Opcion 6: Salir"

read -p "Ingrese el número de la opción elegida: " opcion_elegida

while [ $opcion_elegida -ne 6 ]; do
    case $opcion_elegida in
        1)
            echo "Creando entorno dentro de $HOME..."
            
            # Utilizamos el flag '-p' para crear directorios en una línea
            mkdir -p $DIRECTORIO_ENTRADA $DIRECTORIO_PROCESADO $DIRECTORIO_SALIDA
            
            cp "./consolidar.sh" "$HOME/EPNro1/consolidar.sh"

            # Creamos el archivo de salida en el proceso de creación de entorno
            if [ -z "$FILENAME" ]; then
                echo "La variable FILENAME no está definida. Usando nombre por defecto..."
                export FILENAME="consolidado_defecto"
            fi
            touch "$DIRECTORIO_SALIDA$FILENAME.txt"

            echo "Directorios y archivo de salida $FILENAME.txt creados"
            ;;
        2)
            # 1. Verificamos si los directorios NO existen
            if [[ -d "$DIRECTORIO_ENTRADA" || -d "$DIRECTORIO_SALIDA" || -d "$DIRECTORIO_PROCESADO" ]]; then
                echo "Corriendo procesamiento en background..."
                bash $HOME/EPNro1/consolidar.sh &
            else
                echo "No se encuentran los directorios para ejecutar este proceso. Por favor, elegir la opción 1."
            fi
            ;;
        3)  
            if [ -f "$FILENAME" ]; then
                echo "Archivo ordenado por número de padrón"
                sort -n -k1,1 < "$FILENAME" 
            else
                echo "Error: El archivo $FILENAME no existe."
            fi
            ;;
        4)
            echo "Opción 4 - pendiente"
            ;;
        5)
            echo "Opción 5 - pendiente"
            ;;
        6)
            echo "Saliendo..."
            break
    esac
    read -p "Ingrese el número de otra opción elegida: " opcion_elegida
done

echo "¡Hasta Luego!"