import socket

# Configuramos la "trampa" en el puerto 4444
puerto = 4444
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
    s.bind(("0.0.0.0", puerto))
    s.listen(1)
    print(f"--- ALARMA ACTIVADA EN EL PUERTO {puerto} ---")
    print("Esperando a que alguien intente entrar...")

    while True:
        conexion, direccion = s.accept()
        print(f"⚠️ ¡ALERTA!import os
        os.system("termux-tts-speak 'Alerta, intruso detectado'")
        os.system("termux-vibrate -d 1000") # ¡Para que también tiemble la tablet!
 Intento de conexión desde: {direccion[0]}")
        conexion.send(b"Epa chamo, te vi! Acceso denegado.\n")
        conexion.close()
except:
    print("Error: Quizás el puerto ya está en uso.")
print(f"⚠️ ¡ALERTA! Conexión desde: {direccion[0]}")
        
        # Aquí metes tu código ganador
        import os
        os.system("termux-tts-speak 'Alerta detectada'")
        os.system("termux-vibrate -d 500") # Para que también tiemb
