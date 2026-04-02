import requests
import time

def revisar(url):
    print(f"Probando conexión con: {url}...")
    try:
        # Hacemos una petición rápida (timeout de 5 seg para que no dé lag)
        inicio = time.time()
        r = requests.get(url, timeout=5)
        fin = time.time()
        
        tiempo_ms = round((fin - inicio) * 1000)
        
        if r.status_code == 200:
            print(f"✅ ¡ACTIVA! Respondió en {tiempo_ms}ms")
        else:
            print(f"⚠️ RARO: El código de respuesta es {r.status_code}")
            
    except:
        print("❌ CAÍDA: No hay respuesta o el internet está muerto.")

# Aquí puedes poner la página que quieras probar
target = "https://www.google.com"
revisar(target)

