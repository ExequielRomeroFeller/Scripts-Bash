#!/bin/bash

#Parametros de ejecucion
DBNAME=""   
BANDERA="0"

#Parametros de conexion
SERVERNAME="localhost"
USER="root"
ENCRIPTADO=$(cat /SCRIPT/password.txt)
LLAVE=""
    
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

function configurarUsuarios {
R="r"
U="u"
RD="_rd"
WR="_wr"
ADM="_adm"
APP="_app"

 #Tipos de Roles y usuarios a crear
    ROLELECTURA="$R$DBNAMECORTADA$RD"
    ROLESCRITURA="$R$DBNAMECORTADA$WR"
    ROLEADM="$R$DBNAMECORTADA$ADM"

    USERLECTURA="$U$DBNAMECORTADA$RD"
    USERESCRITURA="$U$DBNAMECORTADA$WR"
    USERADM="$U$DBNAMECORTADA$APP" 

    USUARIOSADM=("LUCIANO" "GABI" "GUILLE" "MIRTA" "PIOJO")

    ANEXOWR="WR2020"
    ANEXORD="RD2020"
    ANEXOADM="APP2020"
    PASSWR="$DBNAMECORTADA$ANEXOWR"
    PASSRD="$DBNAMECORTADA$ANEXORD"
    PASSAPP="$DBNAMECORTADA$ANEXOADM"
    PASSRDUP=$(echo "$PASSRD" | sed 's/^\(.\)/\U\1/')
    PASSWRUP=$(echo "$PASSWR" | sed 's/^\(.\)/\U\1/')
    PASSAPPUP=$(echo "$PASSAPP" | sed 's/^\(.\)/\U\1/')
}

function crearBase {
    mysqladmin -u $USER -p$PASS create $DBNAME
    echo "La base $DBNAME se creó correctamente."
}

function verBase {
    #Muestra en pantalla las tablas que se encuentran en el mysql local
    mysql -u $USER -p$PASS -e "SHOW DATABASES"
}

function crearRoles {
        #Creamos los 3 roles que se encuentran en todos los servidores, Rol Lectura, Escritura y Adm
        mysql -u $USER -p$PASS -e "CREATE ROLE '$ROLELECTURA'@'%'; GRANT SELECT ON $DBNAME.* TO '$ROLELECTURA';"
        mysql -u $USER -p$PASS -e "CREATE ROLE '$ROLESCRITURA'@'%'; GRANT INSERT,UPDATE,DELETE ON $DBNAME.* TO '$ROLESCRITURA';"
        mysql -u $USER -p$PASS -e "CREATE ROLE '$ROLEADM'@'%'; GRANT ALL ON $DBNAME.* TO '$ROLEADM';"
}

function crearUsuarios {
    #Creamos los usuarios a los cuales se le asignan los Roles.
    mysql -u $USER -p$PASS -e "CREATE USER '$USERLECTURA'@'$SERVERNAME' IDENTIFIED WITH mysql_native_password BY '$PASSRDUP'; GRANT $ROLELECTURA TO $USERLECTURA@$SERVERNAME; SET DEFAULT ROLE ALL TO $USERLECTURA@$SERVERNAME;"
    mysql -u $USER -p$PASS -e "CREATE USER '$USERESCRITURA'@'$SERVERNAME' IDENTIFIED WITH mysql_native_password BY '$PASSWRUP'; GRANT '$ROLESCRITURA','$ROLELECTURA' TO $USERESCRITURA@$SERVERNAME; SET DEFAULT ROLE ALL TO $USERESCRITURA@$SERVERNAME;"
}

function crearUsuarioAdm {
    #Creamos el usuario con permisos de administración, se realiza por pedido, no en todos los servidores estará
    mysql -u $USER -p$PASS -e "CREATE USER '$USERADM'@'$SERVERNAME' IDENTIFIED WITH mysql_native_password BY '$PASSAPPUP'; GRANT 'rcodificador_rd'@'%','$ROLESCRITURA','$ROLELECTURA' TO '$USERADM'@'$SERVERNAME'; SET DEFAULT ROLE ALL TO '$USERADM'@'$SERVERNAME';"
}

function crearUsuariosDesarrollo {
    for dato in ${USUARIOSADM[@]}; do
    mysql -u $USER -p$PASS -e "GRANT '$ROLEADM'@'%' TO '$dato'@'$SERVERNAME'; SET DEFAULT ROLE ALL TO '$dato'@'$SERVERNAME';"
    done
    }

function usuarioDesaADM {
mysql -u $USER -p$PASS -e "GRANT '$ROLESCRITURA','$ROLELECTURA' TO 'udesa_adm'@$SERVERNAME; SET DEFAULT ROLE ALL TO 'udesa_adm'@$SERVERNAME;"
}

function preguntarPass {
    echo "Ingrese la contraseña de desencriptado: "
    read -s LLAVE
    PASS=$(echo "$ENCRIPTADO" | openssl enc -pbkdf2 -a -d -salt -pass pass:"$LLAVE")
}

while getopts "a:,u:,s,p:" FLAG; do
        case "${FLAG}" in
                a)
                BANDERA="0"
                DBNAME=${OPTARG}
                preguntarPass
                echo "Se creará la base $DBNAME."
                echo "¿Desea continuar? [y/n]"
                read RESPUESTA
                comprobarBase "$DBNAME"
                if [ $RESPUESTA == y -a $BANDERA == "0" ]; then
                        #Si el nombre de la base contiene _, lo eliminamos para usarlo en la creación de usuarios y roles
                        DBNAMECORTADA=$(echo $DBNAME | sed 's/_//g')
                        
                        #Configuramos nombres de usuarios y contraseñas
                        configurarUsuarios
                        
                        #Creamos base de datos
                        crearBase
                        
                        #Llamammos a la función crear los roles para usuarios.
                        crearRoles
                        
                        #Creamos los usuarios de acceso
                        crearUsuarios
                        
			        echo "LA BASE DE DATOS ES DE PRODUCCIÓN"
                	echo "¿Desea continuar? [y/n]"
                	read RESPUESTA
                	if [ $RESPUESTA == y ]; then
                        usuarioDesaADM
			        else
			        #Creamos los usuarios admin de desarrollo
                        crearUsuariosDesarrollo
			        fi

                        echo "La base $DBNAME fué creada con Éxito :)."
                    else
                        echo "No se realizó la operación, la base ingresada no existe o se canceló."
                    fi
                    echo "Desea crear el usuario administrador para la base: $DBNAME."
                    echo "Seleccione [y/n]"
                    read RESPUESTA
                    if [ $RESPUESTA == y ]; then
                        crearUsuarioAdm
                        echo "El usuario Administrador fué creado con Éxito :)."
                    fi
                ;;
                u)
                DBNAME=${OPTARG}
                preguntarPass
                echo "Se creará el usuario Administrador para la base $DBNAME"
                echo "¿Desea continuar? [y/n]"
                read RESPUESTA
                comprobarBase "$BASE"
                if [ $RESPUESTA == y -a $BANDERA == "0" ]; then
                        #Si el nombre de la base contiene _, lo eliminamos para usarlo en la creación de usuarios$
                        DBNAMECORTADA=$(echo $DBNAME | sed 's/_//g')

                        #Configuramos nombres de usuarios y contraseñas
                        configurarUsuarios

			            crearUsuarioAdm
                        echo "El usuario Administrador fué creado con Éxito :)."
                else
                        echo "El usuario Administrador no fué creado, la base ingresada no existe o se canecló la operación."
                fi
                ;;
                s)
                preguntarPass
                echo "Se mostrará las bases que contiene su SQL-Server actualmente."
                verBase
		        ;;
                p)
                USUARIO=${OPTARG}
                preguntarPass
		        echo "Ingrese la nueva contraseña para $USUARIO."
		        read RESPUESTA
		        mysql -u $USER -p$PASS -e "ALTER USER '$USUARIO'@'$SERVERNAME' IDENTIFIED BY '$RESPUESTA';"
		        echo "La nueva contraseña para el $USUARIO es: $RESPUESTA"
		        ;;
                *)
                echo "Opción inválida, Las opciones son -a (add), -u (user-admin), -s (show), -p (password)."
                echo "El formato del comando para agregar una base de datos es: nuevaBase -a nombreBase."
                echo "El formato del comando para agregar el usuario administrador a una base de datos: nuevaBase -u nombreBase."
                echo "El formato del comando para ver las bases actuales cargadas en mysql-server es: nuevaBase -s."
		        echo "El formato del comando para cambiar la contraseña de un usuario especificado es: nuevaBase -p NombreUsuario -p."
        esac
done

