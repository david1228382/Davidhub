import os
import json

print("--- ESTADO DE TU BATERÍA ---")
# Esto le pide la info al sistema Android
info = os.popen("termux-battery-status").read()
datos = json.loads(info)

porcentaje = datos['percentage']
estado = datos['status']
temp = datos['temperature']

print(f"Carga: {porcentaje}%")
print(f"Estado: {estado}")
print(f"Temperatura: {temp}°C")

if temp > 40:
    print("¡Epa, chamo! La tablet está muy caliente. Déjala descansar

