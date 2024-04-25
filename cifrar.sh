#!/bin/bash

# CONTRASEÑA A CIFRAR
PASSWORD="TU_PASSWORD_ROOT"

# LLAVE DE CIFRADO
LLAVE="TU_LLAVE"

# Cifrar la contraseña utilizando la clave generada
ENCRIPTADO=$(echo "$PASSWORD" | openssl enc -pbkdf2 -a -salt -pass pass:"$LLAVE")

# Guardar la contraseña cifrada en un archivo
echo "$ENCRIPTADO" > ./password.txt

echo "Contraseña cifrada guardada en password.txt"
