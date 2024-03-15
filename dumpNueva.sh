#!/bin/bash

#Definición de variables
USER="TU_USUARIO"
PASS="TU_CONTRASEÑA"
MYSQLUSER="back_my"
BASE=""
BACKUP="/mnt/clients/infraNueva"
BANDERA="0"
COMPROBARBASE=""
CONSULTA=""

#Definición de funciones

function comprobarBase {
    #Comprueba si la base de datos ya existe en mysql local.
    COMPROBARBASE=$1
    CONSULTA=$(mysql --login-path=$MYSQLUSER -e "SHOW DATABASES LIKE '$COMPROBARBASE'")
    if [ -z "$CONSULTA" ]; then
        echo "La base de datos $COMPROBARBASE NO EXISTE."
    else
        echo "La base de datos $COMPROBARBASE EXISTE."
        BANDERA="1"
    fi
}

function dumpBase {
    #Creamos un backup de la base completa de producción 
    mysqldump --login-path=$MYSQLUSER --single-transaction --add-drop-table --set-gtid-purged=OFF -q $BASE > $BACKUP/$BASE.sql
    echo "El BACKUP de la base $BASE se realizó correctamente."    
}

function verBase {
    #Muestra en pantalla las tablas que se encuentran en el mysql local
    mysql --login-path=$MYSQLUSER -e "show databases"
}

while getopts "b:,s" FLAG; do
    case "${FLAG}" in
        b)
            BANDERA="0"
            BASE=${OPTARG}
            echo "Se creará un backup de la base de producción $BASE"
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
        s)
            echo "Se mostrará las bases que contiene su SQL-Server actualmente."
            verBase
        ;;
        *)
            echo "Opcion inválida, Las opciones son -b (bkp), -s (show)"
            echo "El formato del comando para realizar backup de la base actual es: dump -b nombreBase."
            echo "El formato del comando para ver las bases actuales cargadas en mysql-server es: dump -s."
        esac
done
