import pyautogui
import webbrowser
import time
from faker import Faker

#Para que el llenado funcione correctamente el zoom de Chrome tiene que estar en 67%

fake=Faker()
correo1 = fake.email()
correo2 = fake.email()

url = 'https://forms.office.com/r/S8Jy6Jsvmh'
webbrowser.get('C:/Program Files (x86)/Google/Chrome/Application/chrome.exe %s').open(url)

#Enviando primer respuesta
time.sleep(10)

#pyautogui.click(100, 100)
#Seleccionar marvel
pyautogui.click(x=670, y = 440, clicks = 1)
time.sleep(2)

pyautogui.click(x=680, y = 650, clicks = 1)
time.sleep(1)
frase1 = "Avengers Assemble"
pyautogui.typewrite(frase1)
time.sleep(2)

#Escoger hora 9:00 am
pyautogui.click(x=680, y = 780, clicks = 1)
time.sleep(1)
pyautogui.click(x=680, y = 840, clicks = 1)
time.sleep(2)

#Ingresar correo 1
pyautogui.click(x=680, y = 910, clicks = 1)
time.sleep(1)
pyautogui.typewrite(correo1)
time.sleep(3)

#Enviar respuesta
pyautogui.click(x=680, y = 980, clicks = 1)
time.sleep(1)

#Entrando a segundo formulario
pyautogui.click(x=690, y=445, clicks = 1)
time.sleep(3)

#Llenado de respuesta segundo formulario

#Escoger DC
pyautogui.click(x=670, y = 470, clicks = 1)
time.sleep(1)

#Segunda frase
pyautogui.click(x=680, y = 650, clicks = 1)
time.sleep(1)
frase2 = "Im Batman"
pyautogui.typewrite(frase2)
time.sleep(2)

#Escoger hora 10:00
pyautogui.click(x=690, y = 780, clicks = 1)
time.sleep(1)
pyautogui.click(x=690, y = 870, clicks = 1)
time.sleep(1)

#Ingresar correo 2
pyautogui.click(x=690, y = 910, clicks = 1)
time.sleep(1)
pyautogui.typewrite(correo2)
time.sleep(1)

#Enviar segundo formulario
pyautogui.click(x=700, y = 980, clicks = 1)


print("Correo1: ", correo1)
print("Correo2: " correo2)
print("Formularios enviados")