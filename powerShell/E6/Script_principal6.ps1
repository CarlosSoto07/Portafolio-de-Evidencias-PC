#jose humberto mtz , carlos soto y Gerson Reyes

Function menu {
    Clear-Host
    Write-Host "Selecciona la funcion deseada"
    Write-Host "1. Ver el Perfil de red actual"
    Write-Host "2. Ver las Reglas de Bloqueo"
    Write-Host "3. Ver el Status del Perfil"
    Write-Host "4. Exit"
}
 
menu
 
while(($inp = Read-Host -Prompt "Select an option") -ne "4"){
 
switch($inp){
        1 {
            Clear-Host
            Ver-PerfilRedActual
            pause;
            break
        }
        2 {
            Clear-Host
            Ver-ReglasBloqueo
            pause; 
            break
        }
        3 {
            Clear-Host
            Ver-StatusPerfil
            pause;
            break
            }
        4 {"Exit"; break}
        default {Write-Host -ForegroundColor red -BackgroundColor white "Porfavor Selecciona las opciones correctas";pause}
        
    }
 
menu
}