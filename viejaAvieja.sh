#!/bin/bash

#Definición de variables
USER="TU_USUARIO"
PASS="TU_CONTRASEÑA"
BASE=""
BACKUP="/mnt/clients/infraVieja"
FECHA=$(date +%Y:%m:%d)
LOGFILE="/mnt/clients/infraVieja/LOG_DUMP.log"
BANDERA="0"
COMPROBARBASE=""
CONSULTA=""
NUEVABASE=""
BASECORTADA=""

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

function backupBase {
    #Creamos un backup de la base que se encuentra en el mysql local con el mismo nombre y agregando fecha_actual-bkp 
    BANDERA="0"
    NUEVABASE="$BASE-$FECHA-bkp"
    comprobarBase "$NUEVABASE"
    if [ $BANDERA == "0" ]; then
        mysqladmin -u $USER -p$PASS create $NUEVABASE
        mysqldump -u $USER -v $BASE -p$PASS | mysql -u $USER -p$PASS -D $NUEVABASE
	echo "El BACKUP de la base $NUEVABASE se realizó correctamente."
    fi
}

function restaurarBase {
    #Restaura una base de datos con el último backup que se realizó en producción.
    mysqladmin -u $USER -p$PASS drop $BASE
    mysqladmin -u $USER -p$PASS --default-character-set=latin1 create $BASE
    mysql -u $USER -p$PASS $BASE < $BACKUP/$BASE.sql
}

function verBase {
    #Muestra en pantalla las tablas que se encuentran en el mysql local
    mysql -u $USER -p$PASS -e "show databases"
}

function recuperarBackupLocal {
    #Restaura una base de datos en con los backup creados localmente con el SCRIPT
    BASECORTADA=$(echo $BASE | cut -d'-' -f1)
    mysqldump -u root -p$PASS --single-transaction --add-drop-table -q $BASE > /SCRIPT/Pivote.sql
    mysqladmin -u $USER -p$PASS drop $BASECORTADA
    mysqladmin -u $USER -p$PASS create $BASECORTADA
    mysql -u $USER -p$PASS $BASECORTADA < /SCRIPT/Pivote.sql
    rm /SCRIPT/Pivote.sql
}

function crearBackupInfraNueva {
    #Crea un Backup con solo los datos de la base ingresada, necesaria para importarlas en la nueva infraestructura.
    mysqldump -u $USER -p$PASS --single-transaction --no-create-info --compact $BASE > $BACKUP/haciaNueva/$BASE.sql    
}

function contadorCenteno {
#Crea un Backup con solo los datos de la base ingresada, necesaria para importarlas en la nueva infraestructura.
> $LOGFILE
echo "================================LOG $FECHA=====================================" >> $LOGFILE
echo >> $LOGFILE
mysql -u $USER -p$PASS -Nse 'SHOW TABLES' $BASE | while read table; do mysql -u $USER -p$PASS -e "SELECT CONCAT('$table','=',COUNT(1)) AS '' FROM $table;" $BASE | grep -v test >> $LOGFILE; done }

while getopts "a:,b:,s,r:,p:" FLAG; do
    case "${FLAG}" in
        a)  
            BANDERA="0"
            BASE=${OPTARG}
	        echo "Se restaurará la base $BASE con el backup de producción del día anterior."
	        echo "¿Desea continuar? [y/n]"
	        read RESPUESTA
	        comprobarBase "$BASE"
            if [ $RESPUESTA == y -a $BANDERA == "1" ]; then
                restaurarBase
                echo "La base $BASE fué restaurada con el backup de producción."
            else
                echo "No se realizó la restauración, la base ingresada no existe o canceló la operación."
            fi
	;;
        b)
            BANDERA="0"
            BASE=${OPTARG}
            echo "Se creará un backup local de la base $BASE"
            echo "¿Desea continuar? [y/n]"
            read RESPUESTA
            comprobarBase "$BASE"
            if [ $RESPUESTA == y -a $BANDERA == "1" ]; then
                backupBase
                echo "Se realizó el Backup requerido con el nombre $NUEVABASE."
            else
                echo "No se realizó el Backup, la base ingresada no existe o se canecló la operación."
            fi
        ;;
        s)
            echo "Se mostrará las bases que contiene su SQL-Server actualmente."
            verBase
	;;
	r)
            BANDERA="0"
            BASE=${OPTARG}
            echo "Se volverá atrás con el backup local $BASE"
	        echo "¿Desea continuar? [y/n]"
            read RESPUESTA
            comprobarBase "$BASE"
            if [ $RESPUESTA == y -a $BANDERA == "1" ]; then
                recuperarBackupLocal
                echo "Se finalizó la restauración de $BASECORTADA con el Backup $BASE"
            else
	        echo "No se realizó la restauración, la base ingresada no existe o seleccionó la opción NO."
            fi
	;;
	p)
            BASE=${OPTARG}
            echo "Se creará un backup de la base $BASE para pasar a Infraestructura Nueva"
	        echo "¿Desea continuar? [y/n]"
            read RESPUESTA
            if [ $RESPUESTA == y ]; then
                contadorCenteno
		        crearBackupInfraNueva
	            echo "Se finalizó el backup de la base $BASE, ya se puede restaurar en la nueva infraestructura"
	    else
                echo "No se realizó el Backup, la base ingresada no existe o se canceló la operación."
            fi
	;;
	*)
            echo "Opcion inválida, Las opciones son -a (add), -b (bkp), -s (show), -p (pass), -r (rollback)"
            echo "El formato del comando para actualizar base con datos de producción: viejaAvieja -a nombreBase."
            echo "El formato del comando para realizar backup de la base actual es: viejaAvieja -b nombreBase."
	        echo "El formato del comando para recuperar la base con un backup local es: viejaAvieja -r nombreBase."
            echo "El formato del comando para ver las bases actuales cargadas en mysql-server es: viejaAvieja -s."
            echo "El formato del comando para crear un backup de solo datos para infraestructura nueva es: viejaAvieja -p nombreBase."    
        esac
done
