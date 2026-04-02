import requests
print("--- REVISANDO TU RED ---")
try:
    ip = requests.get('https://api.ipify.org').text
    print(f"Tu IP pública es: {ip}")
    print("Estado: Conectado y listo para hackear (ético).")
except:
    print("Error: No tienes internet o el servidor está lento.")

