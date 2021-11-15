import requests
from bs4 import BeautifulSoup
import os
import argparse

parser = argparse.ArgumentParser() 
parser.add_argument("-link", dest="link1", help="Ingresa el link por favor")
params = parser.parse_args()  
print(params)
print(type(params))
print(params.link1)
print(type(params.link1))

def Imagenes(url, carpeta):
    try:
        os.mkdir(os.path.join(os.getcwd(), carpeta))
        print("Carpeta creada")
    except:
        pass
        print("Carpeta creada con aterioridad, imagenes guardadas")
    os.chdir(os.path.join(os.getcwd(), carpeta))

    r = requests.get(url)
    soup = BeautifulSoup(r.text, 'html.parser')
    #imagen = soup.find_all("span",{"class":"img"},limit=10)
    imagen= soup.find_all('img')[11:20]
    cont =1
    for image in imagen:
        NombreImagen = "img" + str(cont) + ".jpg"
        link = image['src']
        cont +=1
        with open(NombreImagen, 'wb') as f:
            im = requests.get(link)
            f.write(im.content)
            print('Guardando Imagen: ', NombreImagen)

Imagenes(url='https://www.rayados.com/fotogalerias/lista', carpeta='ImagenesRayados')

from PIL.ExifTags import TAGS, GPSTAGS
from PIL import Image
import os

def decode_gps_info(exif):
    gpsinfo = {}
    if 'GPSInfo' in exif:
        #Parse geo references.
        print(exif['GPSInfo'])
        input("...")
        Nsec = exif['GPSInfo'][2][2] 
        Nmin = exif['GPSInfo'][2][1]
        Ndeg = exif['GPSInfo'][2][0]
        Wsec = exif['GPSInfo'][4][2]
        Wmin = exif['GPSInfo'][4][1]
        Wdeg = exif['GPSInfo'][4][0]
        if exif['GPSInfo'][1] == 'N':
            Nmult = 1
        else:
            Nmult = -1
        if exif['GPSInfo'][3] == 'E':
            Wmult = 1
        else:
            Wmult = -1
        Lat = Nmult * (Ndeg + (Nmin + Nsec/60.0)/60.0)
        Lng = Wmult * (Wdeg + (Wmin + Wsec/60.0)/60.0)
        exif['GPSInfo'] = {"Lat" : Lat, "Lng" : Lng}
        input()

 
def get_exif_metadata(image_path):
    ret = {}
    image = Image.open(image_path)
    if hasattr(image, '_getexif'):
        exifinfo = image._getexif()
        if exifinfo is not None:
            for tag, value in exifinfo.items():
                decoded = TAGS.get(tag, tag)
                ret[decoded] = value
    decode_gps_info(ret)
    return ret
    
def printMeta():
    ruta = input("Ruta de imágenes: ")
    os.chdir(ruta)
    for root, dirs, files in os.walk(".", topdown=False):
        for name in files:
            print(os.path.join(root, name))
            print ("[+] Metadata for file: %s " %(name))
            input()
            try:
                exifData = {}
                exif = get_exif_metadata(name)
                for metadata in exif:
                    print ("Metadata: %s - Value: %s " %(metadata, exif[metadata]))
                print ("\n")
            except:
                import sys, traceback
                traceback.print_exc(file=sys.stdout)
printMeta()
