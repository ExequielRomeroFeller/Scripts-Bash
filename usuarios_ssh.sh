#!/bin/bash

#Definición de funciones

function crearUsuario {
        useradd -m $1
        mkdir /home/$1/.ssh
        chown $1:$1 /home/$1/.ssh
        cp ./claves/$1.pub /home/$1/.ssh/authorized_keys
        chown $1:users /home/$1/.ssh/authorized_keys
        chmod 644 /home/$1/.ssh/authorized_keys
        echo "Se creo el usuario $1"
}

function agregarUsuario {
        while read linea; do
                if [ $linea == sexequiel -o $linea == scristian -o $linea == sjorge -o $linea == sgabriel -o $linea == swalter ]; then
                        echo "Agregando usuario: $linea"
                        crearUsuario "$linea"
                        else
                        echo "El usuario: $linea, no pertenece al área de informática. Si es nuevo, debe modificar el condcional IF con el nombre del nuevo usuario."
                fi
        done < usuarios.txt
}

function borrarUsuario {
        while read linea; do
            userdel -rf "$linea"
        done < usuarios.txt
}

while getopts "a,d" FLAG; do
    case "${FLAG}" in
        a)
            echo "Se van a crear los usuarios que figuran en el archivo usuarios.txt"
            cat usuarios.txt
            echo "¿Desea continuar? [y/n]"
            read RESPUESTA
            if [ $RESPUESTA == y]; then
                agregarUsuario
            else
                echo "No se crearán los usuarios."
            fi
        ;;
        d)
            echo "Se van a borrar los usuarios que figuran en el archivo usuarios.txt"
            echo "Esto incluye todo el perfil y sus claves públicas"
            cat usuarios.txt
            echo "¿Desea continuar? [y/n]"
            read RESPUESTA
            if [ $RESPUESTA == y]; then
                borrarUsuario
            else
                echo "No se borrarán los usuarios."
            fi
        ;;
        *)
            echo "Opcion inválida, Las opciones son -a y los usuarios a agregar o -d y los usuarios a borrar."
        esac
    done
