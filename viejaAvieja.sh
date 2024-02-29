#!/bin/bash

#Definición de variables
USER="root"
PASS="optiquest"
BASE=""
BACKUP="/mnt/clients/infraVieja"
FECHA=$(date +%Y:%m:%d)
BANDERA="0"
COMPROBARBASE=""
CONSULTA=""
NUEVABASE=""

#Definición de funciones

function comprobarBase {
    COMPROBARBASE=$1
    CONSULTA=$(mysql -u $USER -p$PASS -e "SHOW DATABASES LIKE '$COMPROBARBASE'")
    if [ -z "$CONSULTA" ]; then
        echo "La base de datos $COMPROBARBASE NO EXISTE."
    else
        echo "La base de datos $COMPROBARBASE EXISTE, Ya se realizó un backup."
        BANDERA="1"
    fi
}

function backupBase {
        #Creamos un backup de la base con el mismo nombre y agregando -bkp 
        BANDERA="0"
        NUEVABASE="$BASE-$FECHA-bkp"
        comprobarBase "$NUEVABASE"
        if [ $BANDERA == "0" ]; then
            echo "Se realiza el backup correspondiente."
            mysqladmin -u $USER -p$PASS create $NUEVABASE
            mysqldump -u $USER -v $BASE -p$PASS | mysql -u $USER -p$PASS -D $NUEVABASE
        fi
}

function restaurarBase {
        #Borramos y creamos la base vaciá
        mysqladmin -u $USER -p$PASS drop $BASE
        mysqladmin -u $USER -p$PASS --default-character-set=latin1 create $BASE
        #Insertamos datos a la tabla
        mysql -u $USER -p$PASS $BASE < $BACKUP/$BASE.sql
}

function verBase {
        mysql -u $USER -p$PASS -e "show databases"
}


while getopts "a:,b:,s" FLAG; do
    case "${FLAG}" in
        a)  
            BANDERA="0"
            BASE=${OPTARG}
            echo "Se restaurará la base $BASE con el backup de producción del día anterior."
            echo "¿Desea continuar? [y/n]"
            read RESPUESTA
            comprobarBase "$RESPUESTA"
            if [ $RESPUESTA == y -a $BANDERA == "1"]; then
                restaurarBase
                echo "La base $BASE fué restaurada con el backup de producción."
            else
                echo "No se realizó la restauración."
            fi
        ;;
        b)
            BANDERA="0"
            BASE=${OPTARG}
            echo "Se creará un backup de la base $BASE"
            echo "¿Desea continuar? [y/n]"
            read RESPUESTA
            comprobarBase "$RESPUESTA"
            if [ $RESPUESTA == y -a $BANDERA == "1"]; then
                backupBase
                echo "Se realizó el Backup requerido con el nombre $NUEVABASE."
            else
                echo "No se realizó el Backup."
            fi
        ;;
        s)
            echo "Se mostrará las bases que contiene su SQL-Server actualmente."
            verBase
        ;;
        *)
            echo "Opcion inválida, Las opciones son -a (add), -b (bkp) y -s (show)"
            echo "El formato del comando para actualizar base es: viejaAvieja -a nombreBase."
            echo "El formato del comando para realizar backup de la base actual es: viejaAvieja -b nombreBase."
            echo "El formato del comando para ver las bases actuales cargadas en mysql-server es: viejaAvieja -s."
    esac
done
