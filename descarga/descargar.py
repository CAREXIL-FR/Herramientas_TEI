import wget
import os

# Ruta al directorio en el que se descargarán los archivos
dirSalida = 'xml'

# Fichero que contiene la lista de documentos que hay que descargar
lista = 'archivos.txt'

#URL del proyecto
urlBase =  'http://carexil.huma-num.fr'

#tipo de documento a descargar. Valores posibles: 'tei' o 'raw'
tipo = 'raw'

if not os.path.exists(dirSalida):
        os.mkdir(dirSalida)


f = open(lista)
archivos = f.readlines()

for doc in archivos:
    url = urlBase + '/index.php?action=getxml&type=' + tipo + '&cid=' + doc
    wget.download(url, 'xml')
