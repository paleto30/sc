#!/bin/bash

sala = "";
echo "Elija la sala para crear la configuracion de apache2"
echo "1. Sputnik"
echo "2. Apolo"
echo "3. Artemis"
read -p "Seleccione una opción: " opcion
case $opcion in
  1)
    sala="spuk *"
    ;;
  2)
    sala="apol *"
    ;;
  3)
    sala="arte *"
    ;;
  *)
    echo "Opción no válida"
    ;;
esac

sudo apt install apache2 && sudo ufw allow 'Apache' && sudo ufw enable && cd /var/www/html/ && sudo rm -r index.html

lista_usuarios=$(cut -d: -f1 /etc/passwd)
lista_usuarios_ordenada=$(echo "$lista_usuarios" | tr ' ' '\n' | grep "$sala")
for usuario in "$lista_usuarios_ordenada"
do
    carpeta=$(echo "$usuario" | sed 's/a/A/;s/s/S/;s/m/M/;s/n/N/;s/\(.*\)t/\1T/')
    sudo mkdir $carpeta && sudo chown $usuario:$usuario $carpeta && sudo chmod u+rwx $carpeta
done
