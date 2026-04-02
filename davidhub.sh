#!/bin/bash

# --- DAVIDHUB: EL BUSCADOR ---
VERDE='\033[0;32m'
CYAN='\033[0;36m'
SIN_COLOR='\033[0m'

clear
echo -e "${VERDE}-------------------------------------------------------"
echo "        BIENVENIDO A DAVIDHUB - EL BUSCADOR            "
echo -e "-------------------------------------------------------${SIN_COLOR}"

echo -e "\n${CYAN}¿Qué script quieres buscar hoy, David? (Escribe el nombre):${SIN_COLOR}"
read -p ">> " busqueda

# Convertimos a minúsculas
busqueda=$(echo "$busqueda" | tr '[:upper:]' '[:lower:]')

case $busqueda in
    "delta")
        echo -e "${VERDE}[!] Entrando al módulo Delta...${SIN_COLOR}"
        echo -e "1) Crear nuevo script Delta"
        echo -e "2) Ver scripts guardados"
        read -p "Selecciona una opción: " op_delta
        
        case $op_delta in
            1) 
                read -p "Nombre del nuevo archivo: " nuevo
                nano "$nuevo.py" 
                ;;
            2) 
                ls *.py 2>/dev/null || echo "No hay nada todavía."
                ;;
            *) 
                echo "Volviendo..."
                ;;
        esac
        ;;

    "github")
        echo -e "${VERDE}[!] Sincronizando con GitHub...${SIN_COLOR}"
        git add .
        read -p "Mensaje del commit: " msj
        git commit -m "$msj"
        git push
        ;;

    *)
        echo -e "Mano, '$busqueda' no aparece. Prueba con 'delta' o 'github'."
        ;;
esac

echo -e "\nProceso finalizado. Presiona Enter para salir."
read
