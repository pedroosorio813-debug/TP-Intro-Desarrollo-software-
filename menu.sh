#!/bin/bash

export DIRECTORIO_HOME="$HOME/EPNro1"
# En caso de que se especifique parámetro '-d', cierra procesos en background y limpia las variables de entorno creadas
# Además, en caso de que no haya tales directorios, procesos o variables, no tira error
if [ "$1" == "-d" ]; then # Las comillas son importantes para que no tire error en caso de que no se especifique el parámetro
    echo "Finalizando proceso 'consolidar.sh'..."
    pkill -f consolidar.sh
    echo "Limpiando directorio $DIRECTORIO_HOME..."
    rm -rf "$DIRECTORIO_HOME"
    echo "Limpiando variables en memoria..."
    unset FILENAME DIRECTORIO_ENTRADA DIRECTORIO_SALIDA DIRECTORIO_PROCESADO DIRECTORIO_HOME
    exit 0
fi

# Creo las variables de los directorios para mayor claridad en las rutas
# A su vez, exporto las variables para emplearlas dentro de consolidar.sh 
export DIRECTORIO_ENTRADA="$HOME/EPNro1/entrada/"
export DIRECTORIO_SALIDA="$HOME/EPNro1/salida/"
export DIRECTORIO_PROCESADO="$HOME/EPNro1/procesado/"
export ARCHIVO_SALIDA="$DIRECTORIO_SALIDA$FILENAME.txt"

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
            touch "$ARCHIVO_SALIDA"

            echo "Directorios y archivo de salida $FILENAME.txt creados"
            ;;
        2)
            # 1. Verificamos si los directorios NO existen
            if [[ -d "$DIRECTORIO_ENTRADA" && -d "$DIRECTORIO_SALIDA" && -d "$DIRECTORIO_PROCESADO" ]]; then
                # Si el proceso ya está corriendo, no se ejecuta de nuevo
                if pgrep -f "consolidar.sh" > /dev/null; then
                    echo "El proceso ya se encuentra corriendo."
                else
                    bash "$HOME/EPNro1/consolidar.sh" &
                    echo "Proceso iniciado correctamente."
                fi
            else
                echo "No se encuentran los directorios para ejecutar este proceso. Por favor, elegir la opción 1."
            fi
            ;;
        3)  
            if [ -f "$ARCHIVO_SALIDA" ]; then
                echo "Archivo ordenado por número de padrón"
                sort -n -k1,1 < "$ARCHIVO_SALIDA" 
            else
                echo "Error: El archivo $ARCHIVO_SALIDA no existe."
            fi
            ;;
        4)
            #Muestra las 10 mejores notas con el -k5 le decimos que busque en la columna numero 5,
            #el -n es para valores numericos y el -r es para que ordene de mayor a menor luego,
            #usamos un pipeline para decirle que se detenga luego de las primeras 10 lineas
            if [ -f "$ARCHIVO_SALIDA" ]; then
                sort -k5nr "$ARCHIVO_SALIDA" | head -10
            else 
                 echo "Error: El archivo $ARCHIVO_SALIDA no existe."
            fi
            ;;
        5)
            echo -n "Ingresá el número de padrón: "
            read padron
            if [ -f "$ARCHIVO_SALIDA" ]; then
                resultado=$(grep "^$padron " "$ARCHIVO_SALIDA")
                if [ -z "$resultado" ]; then
                    echo "No se encontró el padrón $padron."
                else
                    echo "$resultado"
                fi
            else
                echo "No existe el archivo $ARCHIVO_SALIDA"
            fi
            ;;
        6)
            echo "Saliendo..."
            break
            ;;
        *)
            echo "Error: '$opcion_elegida' no es una alternativa válida."
    esac
    read -p "Ingrese el número de otra opción elegida: " opcion_elegida
done

echo "¡Hasta Luego!"
