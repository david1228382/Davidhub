import os

def escanear_red():
    print("--- 📡 ESCANEANDO APARATOS EN TU WIFI ---")
    print("Buscando vecinos... (esto puede tardar un pelo)")
    
    # Este comando de sistema nos da la lista de IPs conectadas
    # Usamos 'ip neigh' porque es el estándar moderno en Linux/Android
    resultado = os.popen("ip neigh show").read()
    
    if not resultado.strip():
        print("❌ No veo a nadie... ¿Estás conectado al WiFi?")
    else:
        lineas = resultado.split("\n")
        contador = 0
        for linea in lineas:
            if "REACHABLE" in linea or "STALE" in linea:
                # Limpiamos la línea para que se vea bonita
                partes = linea.split()
                ip = partes[0]
                mac = partes[4] if len(partes) > 4 else "Desconocida"
                print(f"✅ Dispositivo hallado! -> IP: {ip} | MAC: {mac}")
                contador += 1
        
        print(f"\n--- Escaneo listo. Encontré {contador} aparatos. ---")
        
        # Si encuentra más de 3, ¡que nos avise con voz!
        if contador > 3:
            os.system("termux-tts-speak 'Mano, tienes mucha gente pegada al wifi'")

escanear_red()

