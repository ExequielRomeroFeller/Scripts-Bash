#!/bin/bash
##DEFINICIÓN DE VARIABLES##
FECHA=$(date +%Y:%m:%d)
LOG_NAME="bkp-$FECHA-delegaciones.log"
LOG_FILE="/DATA/SCRIPT/LOG/$LOG_NAME"

#############################ARMADO LOG FINAL######################################
touch $LOG_FILE
> $LOG_FILE
echo ======================================== $LOG_NAME ============================================ >> $LOG_FILE
echo El script se encuentra en: /DATA/SCRIPT/ >> $LOG_FILE
echo "##LISTA DE RSYNC DE BACKUPS##" >> $LOG_FILE

#ENRESS-pclen512-Ubuntu20
LOG_DELEGACION_NAME="ENRESS-pclen512-Ubuntu20.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== ENRESS-pclen512-Ubuntu20 ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -avzhP --exclude '.Trash*' --delete --log-file=$LOG_DELEGACION pasaje@pclen512.tcuentas.sfnet:/home/usuario/RESPALDO/ /DATA/delegaciones/ENRESS/pclen512/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/ENRESS/pclen512 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#PRODUCCION-pclen302-WinXP
LOG_DELEGACION_NAME="PRODUCCION-pclen302-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== PRODUCCION-pclen302-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pclen302.tcuentas.sfnet/respaldo /DATA/delegaciones/PRODUCCION/pclen302/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/PRODUCCION/pclen302 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#CULTURA-pclen283-WinXP
LOG_DELEGACION_NAME="CULTURA-pclen283-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== CULTURA-pclen283-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pclen283.tcuentas.sfnet/respaldo /DATA/delegaciones/CULTURA/pclen283/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/CULTURA/pclen283 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#ECONOMIA-pclen313-Ubuntu16
LOG_DELEGACION_NAME="ECONOMIA-pclen313-Ubuntu16.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== ECONOMIA-pclen313-Ubuntu16 ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -avzhP --exclude '.Trash*' --delete --log-file=$LOG_DELEGACION pasaje@pclen313.tcuentas.sfnet:/home/usuario/RESPALDO/ /DATA/delegaciones/ECONOMIA/pclen313/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/ECONOMIA/pclen313 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#PODER_JUDICIAL-pcclo025-WinXP
LOG_DELEGACION_NAME="PODER_JUDICIAL-pcclo025-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== PODER_JUDICIAL-pcclo025-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcclo025.tcuentas.sfnet/respaldo /DATA/delegaciones/PODER_JUDICIAL/pcclo025/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/PODER_JUDICIAL/pcclo025 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#MIT-pcclo057-WinXP
LOG_DELEGACION_NAME="MIT-pcclo057-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== MIT-pcclo057-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcclo057.tcuentas.sfnet/respaldo /DATA/delegaciones/MIT/pcclo057/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/MIT/pcclo057 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#PROMOCION-pcclo006-WinXP
LOG_DELEGACION_NAME="PROMOCION-pcclo006-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== PROMOCION-pcclo006-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcclo006.tcuentas.sfnet/respaldo /DATA/delegaciones/PROMOCION/pcclo006/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/PROMOCION/pcclo006 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#EDUCACION-pcclo375-WinXP
LOG_DELEGACION_NAME="EDUCACION-pcclo375-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== EDUCACION-pcclo375-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcclo375.tcuentas.sfnet/respaldo /DATA/delegaciones/EDUCACION/pcclo375/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/EDUCACION/pcclo375 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#SALUD(hospitales)-pcclo352-WinXP
LOG_DELEGACION_NAME="SALUD(hospitales)-pcclo352-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== "SALUD(hospitales)-pcclo352-WinXP" ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcclo352.tcuentas.sfnet/respaldo /DATA/delegaciones/SALUD/pcclo352/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/SALUD/pcclo352 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#SALUD-pclen315-WinXP
LOG_DELEGACION_NAME="SALUD-pclen315-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== SALUD-pclen315-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pclen315.tcuentas.sfnet/respaldo /DATA/delegaciones/SALUD/pclen315
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/SALUD/pclen315 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#EPE-ROSARIO-pcdel333-WinXP
LOG_DELEGACION_NAME="EPE-ROSARIO-pcdel333-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== EPE-ROSARIO-pcdel333-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcdel333.tcuentas.sfnet/respaldo /DATA/delegaciones/EPE_ROSARIO/pcdel333/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/EPE_ROSARIO/pcdel333 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#ROSARIO-pclen310-WinXP
LOG_DELEGACION_NAME="ROSARIO-pclen310-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== ROSARIO-pclen310-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pclen310.tcuentas.sfnet/respaldo /DATA/delegaciones/ROSARIO/pclen310/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/ROSARIO/pclen310 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#SEGURIDAD-pcclo001-WinXP
LOG_DELEGACION_NAME="SEGURIDAD-pcclo001-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== SEGURIDAD-pcclo001-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcclo001.tcuentas.sfnet/respaldo /DATA/delegaciones/SEGURIDAD/pcclo001/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/SEGURIDAD/pcclo001 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#SEGURIDAD-pcclo060-Ubuntu16
LOG_DELEGACION_NAME="SEGURIDAD-pcclo060-Ubuntu16.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== SEGURIDAD-pcclo060-Ubuntu16 ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -avzhP --exclude '.Trash*' --delete --log-file=$LOG_DELEGACION pasaje@pcclo060.tcuentas.sfnet:/home/usuario/RESPALDO /DATA/delegaciones/SEGURIDAD/pcclo060/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/SEGURIDAD/pcclo060 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#JUBILACIONES-pclen527-Ubuntu20
LOG_DELEGACION_NAME="JUBILACIONES-pclen527-Ubuntu20.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== JUBILACIONES-pclen527-Ubuntu20 ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -avzhP --exclude '.Trash*' --delete --log-file=$LOG_DELEGACION pasaje@pclen527.tcuentas.sfnet:/home/usuario/RESPALDO/ /DATA/delegaciones/JUBILACIONES/pclen527/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/JUBILACIONES/pclen527 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#JUSTICIA-pcclo376-Ubuntu16
LOG_DELEGACION_NAME="JUSTICIA-pcclo376-Ubuntu16.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== JUSTICIA-pcclo376-Ubuntu16 ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -avzhP --exclude '.Trash*' --delete --log-file=$LOG_DELEGACION pasaje@pcclo376.tcuentas.sfnet:/home/usuario/HDDPCCLO376/Respaldo/ /DATA/delegaciones/JUSTICIA/pcclo376/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/JUSTICIA/pcclo376 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#MOSP-pcclo189-Ubuntu16
LOG_DELEGACION_NAME="MOSP-pcclo189-Ubuntu16.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== MOSP-pcclo189-Ubuntu16 ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -avzhP --exclude '.Trash*' --delete --log-file=$LOG_DELEGACION pasaje@pcclo189.tcuentas.sfnet:/home/usuario/DiscoD/ /DATA/delegaciones/MOSP/pcclo189/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/MOSP/pcclo189 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#TRABAJO-pclen298-Ubuntu16
LOG_DELEGACION_NAME="TRABAJO-pclen298-Ubuntu16.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== TRABAJO-pclen298-Ubuntu16 ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -avzhP --exclude '.Trash*' --delete --log-file=$LOG_DELEGACION pasaje@pclen298.tcuentas.sfnet:/home/usuario/DiscoD/RESPALDO /DATA/delegaciones/TRABAJO/pclen298/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/TRABAJO/pclen298 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#LEGISLATURA-pcclo372-WinXP
LOG_DELEGACION_NAME="LEGISLATURA-pcclo372-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== LEGISLATURA-pcclo372-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcclo372.tcuentas.sfnet/respaldo /DATA/delegaciones/LEGISLATURA/pcclo372/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/LEGISLATURA/pcclo372 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#API-pcclo382-WinXP
LOG_DELEGACION_NAME="API-pcclo382-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== API-pcclo382-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcclo382.tcuentas.sfnet/respaldo /DATA/delegaciones/API/pcclo382/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/API/pcclo382 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#EPE-pcclo363-WinXP
LOG_DELEGACION_NAME="EPE-pcclo363-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== EPE-pcclo363-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcclo363.tcuentas.sfnet/respaldo /DATA/delegaciones/EPE/pcclo363/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/EPE/pcclo363 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#IAPOS-pcdel349-WinXP
LOG_DELEGACION_NAME="IAPOS-pcdel349-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== IAPOS-pcdel349-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcdel349.tcuentas.sfnet/respaldo /DATA/delegaciones/IAPOS/pcdel349/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/IAPOS/pcdel349 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#REFORMA-pclen295-WinXP
LOG_DELEGACION_NAME="REFORMA-pclen295-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== REFORMA-pclen295-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pclen295.tcuentas.sfnet/respaldo /DATA/delegaciones/REFORMA/pclen295/
etail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/REFORMA/pclen295 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#VIALIDAD-pcdel338-WinXP
LOG_DELEGACION_NAME="VIALIDAD-pcdel338-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== VIALIDAD-pcdel338-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcdel338.tcuentas.sfnet/respaldo /DATA/delegaciones/VIALIDAD/pcdel338/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/VIALIDAD/pcdel338 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#BIBLIOTECA-pclen293-WinXP
LOG_DELEGACION_NAME="BIBLIOTECA-pclen293-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== BIBLIOTECA-pclen293-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pclen293.tcuentas.sfnet/respaldo /DATA/delegaciones/BIBLIOTECA/pclen293/respaldo/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/BIBLIOTECA/pclen293/respaldo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pclen293.tcuentas.sfnet/biblioteca /DATA/delegaciones/BIBLIOTECA/pclen293/biblioteca/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/BIBLIOTECA/pclen293/biblioteca | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#VIVIENDA-pcdel335-WinXP
LOG_DELEGACION_NAME="VIVIENDA-pcdel335-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== VIVIENDA-pcdel335-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcdel335.tcuentas.sfnet/respaldo /DATA/delegaciones/VIVIENDA/pcdel335/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/VIVIENDA/pcdel335 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#LOTERIA-pclen297-Ubuntu16
LOG_DELEGACION_NAME="LOTERIA-pclen297-Ubuntu16.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== LOTERIA-pclen297-Ubuntu16 ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -avzhP --exclude '.Trash*' --delete --log-file=$LOG_DELEGACION pasaje@pclen297.tcuentas.sfnet:/home/usuario/Respaldo/ /DATA/delegaciones/LOTERIA/pclen297/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/LOTERIA/pclen297 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

#TESORERIA-pcclo010-WinXP
LOG_DELEGACION_NAME="TESORERIA-pcclo010-WinXP.log"
LOG_DELEGACION="/DATA/SCRIPT/LOG/DELEGACIONES/$LOG_DELEGACION_NAME"
touch $LOG_DELEGACION
> $LOG_DELEGACION
echo ======================================== TESORERIA-pcclo010-WinXP ============================================ | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
rsync -aurdtv --exclude '.Trash*' --delete --password-file=/DATA/SCRIPT/.rsync --usermap=4294967295:544 --groupmap=4294967295:197121 --log-file=$LOG_DELEGACION rsync://pcclo010.tcuentas.sfnet/respaldo /DATA/delegaciones/TESORERIA/pcclo010/
tail -n 3 $LOG_DELEGACION >> $LOG_FILE
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo "ERRORES RSYNC" | tee -a $LOG_FILE
grep 'failed' $LOG_DELEGACION | tee -a $LOG_FILE                        
echo | tee -a $LOG_FILE
echo "ESPACIO OCUPADO" | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
du -sh /DATA/delegaciones/TESORERIA/pcclo010 | tee -a $LOG_FILE | tee -a $LOG_DELEGACION
echo | tee -a $LOG_FILE | tee -a $LOG_DELEGACION

###################################ENVIO DEL CORREO################################
DESTINO="tcp.soporte@santafe.gov.ar"
ASUNTO="Log-rsync delegaciones fiscales"

cat $LOG_FILE | mail -s "$ASUNTO" "$DESTINO"

############################### BORRADO DE LOGS VIEJOS #############################
#Borramos backups con antiguedad mayor a 14 días
find /DATA/SCRIPT/LOG/*.log -mtime +14 -type f -delete
