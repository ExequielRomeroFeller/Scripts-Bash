#!/bin/bash
##DEFINICIÓN DE VARIABLES##
FECHA=$(date +%Y:%m:%d)
LOG_NAME="bkp-$FECHA-AFIP.log"
LOG_FILE="/DATA/SCRIPT/LOG/$LOG_NAME"
mkdir /DATA/pclen509-AFIP/"bkp-$FECHA"
CARPETA="/DATA/pclen509-AFIP/bkp-$FECHA/"
LOG_TOTAL="/DATA/SCRIPT/LOG/bases-afip.log"
touch $LOG_TOTAL
> $LOG_TOTAL

#AFIP-pclen509-Win10
touch $LOG_FILE
> $LOG_FILE
rsync -av --prune-empty-dirs --include='*.mdb' --include='*.MDB' --include='*/' --exclude='*' --log-file=$LOG_TOTAL rsync://pclen509.tcuentas.sfnet/respaldo $CARPETA
tail -n 3 $LOG_TOTAL >> $LOG_FILE
echo | tee -a $LOG_FILE
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_TOTAL | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE
du -sh $CARPETA | tee -a $LOG_FILE


###################################ENVIO DEL CORREO################################
DESTINO="tcp.soporte@santafe.gov.ar"
ASUNTO="Log-rsync bases tesoreria"

cat $LOG_FILE | mail -s "$ASUNTO" "$DESTINO"

############################### BORRADO DE BASES VIEJAS #############################
#Borramos backups con antiguedad mayor a 7 días
find /DATA/pclen509-AFIP/ -type d -mtime +7 -type f -delete
