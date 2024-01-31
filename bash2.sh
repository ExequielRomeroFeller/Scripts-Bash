#!/bin/bash

#Una linea que no molesta

function ejecutar () {
 echo hola $1
}

##Condicional for

for VARIABLE in ${@}; do
 ejecutar $VARIABLE
done

##Condicional while

#X=4

#while [[ $X -le 4 ]]; do
# echo el valor de X es X es: $X"
# X=$((X-1))
#done

##Condicional Case

#case $1" in
#start|finish)
# echo Ejecutaste start o fihish"
#;;
#res*)
# echo Ejecutaste una palabra que comienza con res*"
#;;
#*)
# echo El argumento es invalido"
#esac

##Condicional con getopts

while getopts "a:b:" FLAG; do
 case "${FLAG}" in
  a)
   echo "Pasaste la opción a"
   echo "El argumento que se paso es: ${OPTARG}"
  ;;
  b)
   echo "Pasaste la opción b"
   echo "El argumento que se paso es: ${OPTARG}"
  ;;
  *)
   echo "Opción invalida"
 esac
done

#otra linea que modifico
