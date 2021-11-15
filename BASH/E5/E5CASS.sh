#!/bin/bash


function PedirKey(){
 
  echo
  echo -n "Introduzca su APIKEY: "
  read -s apikey
  echo
  
}

function ChecarCorreos(){
  for line in $(cat correos.txt)
  do
    correo=$line
    apiCorreo=`curl -s https://haveibeenpwned.com/api/v3/breachedaccount/$correo?truncateResponse=false -H 'hibp-api-key':$apikey | jq -j '.[] | "Sitio Web: ", .Title, " --- Fecha de vulneración: ", .BreachDate, "\n" '`

    if [[ "$apiCorreo" == "" ]]; then
      echo -e "\n El correo $correo esta seguro."
    else
      echo -----------------------------------------------------------
      echo -e "\nEl correo $correo ha sido vulnerado en:\n $apiCorreo "
      echo -----------------------------------------------------------
    fi
  done
}
PedirKey
ChecarCorreos