import os
import requests
from datetime import datetime

date = datetime.today().strftime('%Y-%m-%d')

# Ruta al directorio en el que se descargarán los archivos
outDir = '../' + date

# Fichero que contiene la lista de documentos que hay que descargar
list = 'archivos.txt'

#URL del proyecto
urlBase =  'http://carexil.huma-num.fr'

#Tipo de documento a descargar. Valores posibles: 'tei' o 'raw'
type = 'raw'

if not os.path.exists(outDir):
        os.mkdir(outDir)

f = open(list)
files = f.read().splitlines()

for file in files:
    url = urlBase + '/index.php?action=getxml&type=' + type + '&cid=' + file
    response = requests.get(url)
    with open(os.path.join(outDir, file), 'wb') as doc:
    	doc.write(response.content)
