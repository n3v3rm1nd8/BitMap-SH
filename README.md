# Información previa

- Herramienta simple y accesible para escanear puertos y sus correspondientes servicios.
- Se puede usar tanto de manera remota (siempre que esten ambos dispositivos en la misma red logicamente) como desde el propio localhost.
- Recomendable no usar la herramienta con una VPN de por medio, ya que el escaneo se ralentizará bastante.
- Si alguien quiere modificar el script a su gusto es totalmente libre.
- Solamente funciona con IPv4 sobre el protocolo TCP.

## Uso
Primero nos clonamos el repositorio:

`$ sudo git clone https://github.com/n3v3rm1nd8/BitMap-SH`

Le damos permisos de ejecucion a ambos scripts:

`$ sudo chmod +x SETUP.sh; chmod +x bitmap.sh`

Nos descargamos las dependencias en el caso de que no las tengamos:

`$ sudo ./SETUP.sh`

Hecho esto, ya podemos usar el script:

`$ sudo ./bitmap.sh --help`
