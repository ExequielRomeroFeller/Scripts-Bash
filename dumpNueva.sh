#!/bin/bash

#Definición de variables
USER="root"
ENCRIPTADO=$(cat /SCRIPT/password.txt)
LLAVE=""
BASE=""
BACKUP="/mnt/clients/infraNueva"
BANDERA="0"
COMPROBARBASE=""
CONSULTA=""

#Definición de funciones
function comprobarBase {
    #Comprueba si la base de datos ya existe en mysql local.
    COMPROBARBASE=$1
    CONSULTA=$(mysql -u $USER -p$PASS -e "SHOW DATABASES LIKE '$COMPROBARBASE'")
    if [ -z "$CONSULTA" ]; then
        echo "La base de datos $COMPROBARBASE NO EXISTE."
    else
        echo "La base de datos $COMPROBARBASE EXISTE."
        BANDERA="1"
    fi
}

function dumpBase {
    #Creamos un backup de la base completa de producción
    mysqldump -u $USER -p$PASS --single-transaction --add-drop-table --set-gtid-purged=OFF -q $BASE > $BACKUP/$BASE.sql
    echo "El BACKUP FULL de la base $BASE se realizó correctamente."
}

function dumpEstructura {
    mysqldump -u $USER -p$PASS --single-transaction --no-data --set-gtid-purged=OFF -q $BASE > $BACKUP/$BASE.sql
    echo "El BACKUP DE LA ESTRUCTURA de la base $BASE se realizó correctamente."
}

function dumpDatos {
    mysqldump -u $USER -p$PASS --single-transaction --no-create-info --set-gtid-purged=OFF -q $BASE > $BACKUP/$BASE.sql
    echo "El BACKUP DE SOLO DATOS de la base $BASE se realizó correctamente."
}

function verBase {
    #Muestra en pantalla las tablas que se encuentran en el mysql local
    mysql -u $USER -p$PASS -e "show databases"
}

function preguntarPass {
    echo "Ingrese la contraseña de desencriptado: "
    read LLAVE
    PASS=$(echo "$ENCRIPTADO" | openssl enc -aes-256-cbc -a -d -salt -pass pass:"$LLAVE")
}

while getopts "b:,e:,d:,s" FLAG; do
    case "${FLAG}" in
        b)
            BANDERA="0"
            BASE=${OPTARG}
            preguntarPass
            echo "Se creará un backup full de la base de producción $BASE"
            echo "¿Desea continuar? [y/n]"
            read RESPUESTA
            comprobarBase "$BASE"
            if [ $RESPUESTA == y -a $BANDERA == "1" ]; then
                dumpBase
                echo "Se realizó el Backup de $BASE."
            else
                echo "No se realizó el Backup, la base ingresada no existe o se canecló la operación."
            fi
        ;;
        e)
            BANDERA="0"
            BASE=${OPTARG}
            preguntarPass
            echo "Se creará un backup de la estructura de la base de producción $BASE"
            echo "¿Desea continuar? [y/n]"
            read RESPUESTA
            comprobarBase "$BASE"
            if [ $RESPUESTA == y -a $BANDERA == "1" ]; then
                dumpEstructura
                echo "Se realizó el Backup de la estructura de la $BASE."
            else
                echo "No se realizó el Backup, la base ingresada no existe o se canecló la operación."
            fi
        ;;
        d)
            BANDERA="0"
            BASE=${OPTARG}
            preguntarPass
            echo "Se creará un backup de los datos de la base de producción $BASE"
            echo "¿Desea continuar? [y/n]"
            read RESPUESTA
            comprobarBase "$BASE"
            if [ $RESPUESTA == y -a $BANDERA == "1" ]; then
                dumpDatos
                echo "Se realizó el Backup de los datos de la $BASE."
            else
                echo "No se realizó el Backup, la base ingresada no existe o se canecló la operación."
            fi
        ;;
        s)
            preguntarPass
            echo "Se mostrará las bases que contiene su SQL-Server actualmente."
            verBase
        ;;
        *)
            echo "Opcion inválida, Las opciones son -b (bkp), -e (estructura), -d (datos) -s (show)"
            echo "El formato del comando para realizar backup de la base actual es: dumpNueva -b nombreBase."
            echo "El formato del comando para realizar backup de la estructura de la base actual es: dumpNueva -e nombreBase."
            echo "El formato del comando para realizar backup de los datos de la base actual es: dumpNueva -d nombreBase."
            echo "El formato del comando para ver las bases actuales cargadas en mysql-server es: dump -s."
        esac
done
