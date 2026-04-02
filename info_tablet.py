import os
import platform

print("--- REPORTE TÉCNICO ---")
# Información del procesador
print(f"Procesador: {platform.machine()}")

# Tiempo que lleva prendida (Uptime)
print("Tiempo encendida:")
os.system("uptime -p")

# Ver si eres usuario Root o no
id_user = os.getuid()
if id_user == 0:
    print("Estado: Eres ROOT (Superusuario)")
else:
    print("Estado: Usuario Normal (Sin Root)")

print("-----------------------")

