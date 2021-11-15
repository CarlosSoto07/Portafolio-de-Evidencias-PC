Write-Host "CarlosSoto, IreniaRosas, GersonEmanuel"

#BUCLE MANTIENE MENU INTERACTIVO
do{ 

#ESTA SECCION IMPRIME MENU INTERACTIVO
# Y LEE ENTRADA USADA EN SWITCH 
Write-Host "**Menu de Modificacion de Firewall**"
Write-Host "1 :Ver estatus de Perfil en FireWall" 
Write-Host "2 :Cambiar estatus de perfiles"
Write-Host "3 :Ver perfiles de nuestra red"
Write-Host "4 :Cambiar nuestra red a otro perfil"
Write-Host "5 :Ver las reglas de bloqueo"
Write-Host "6 :Agregar regla de bloqueo de entrada para un puerto"
Write-Host "7 :Eliminar regla de bloqueo"
Write-Host "8 :Salir del script"
$Entrada = Read-Host -prompt ">"

#SWITCH PARA OPCIONES MENU INTERACTIVO
switch($Entrada){

#Opcion 1, Ver-StatusPerfil
1 {
	function Ver-StatusPerfil{ 
	param([Parameter(Mandatory)] [ValidateSet("Public","Private")] [string] $perfil) 
	$status = Get-NetFirewallProfile -Name $perfil 
	Write-Host "Perfil:" $perfil 
	if($status.enabled){ 
		Write-Host "Status: Activado" 
	} else{ 
		Write-Host "Status: Desactivado" 
	} 

}
break}


#Opcion 2, Cambiar-StatusPerfil
2 {
	function Cambiar-StatusPerfil{ 
	param([Parameter(Mandatory)] [ValidateSet("Public","Private")] [string] $perfil) 
	$status = Get-NetFirewallProfile -Name $perfil 
	Write-Host "Perfil:" $perfil 
	if($status.enabled){ 
		Write-Host "Status actual: Activado" 
		$opc = Read-Host -Promt "Deseas desactivarlo? [Y] Si [N] No" 
		if ($opc -eq "Y"){ 
			Set-NetFirewallProfile -Name $perfil -Enabled False 
		} 
	} else{ 
		Write-Host "Status: Desactivado" 
		$opc = Read-Host -Promt "Deseas activarlo? [Y] Si [N] No" 
		if ($opc -eq "Y"){ 
			Write-Host "Activando perfil" 
			Set-NetFirewallProfile -Name $perfil -Enabled True 
		} 
	} 
	Ver-StatusPerfil -perfil $perfil 
} 
break}


#Opcion 3, Ver-PerfilRedActual
3 {
	function Ver-PerfilRedActual{ 
	$perfilRed = Get-NetConnectionProfile 
	Write-Host "Nombre de red:" $perfilRed.Name 
	Write-Host "Perfil de red:" $perfilRed.NetworkCategory 
} 
break}


#Opcion 4, Cambiar-PerfilRedActual
4 {
	function Cambiar-PerfilRedActual{ 
	$perfilRed = Get-NetConnectionProfile 
	if($perfilRed.NetworkCategory -eq "Public"){ 
		Write-Host "El perfil actual es público" 
		$opc = Read-Host -Prompt "Quieres cambiar a privado? [Y] Si [N] No" 
		if($opc -eq "Y"){ 
			Set-NetConnectionProfile -Name $perfilRed.Name -NetworkCategory Private 
			Write-Host "Perfil cambiado" 
		} 
	} else{ 
		Write-Host "El perfil actual es privado" 
		$opc = Read-Host -Prompt "Quieres cambiar a público? [Y] Si [N] No" 
		if($opc -eq "Y"){ 
			Set-NetConnectionProfile -Name $perfilRed.Name -NetworkCategory Public
			Write-Host "Perfil cambiado" 
		} 
	} 
	Ver-PerfilRedActual 
}
break}


#Opcion 5, Ver-ReglasBloqueo
5 {
	function Ver-ReglasBloqueo{ 
	if(Get-NetFirewallRule -Action Block -Enabled True -ErrorAction SilentlyContinue){ 
		Get-NetFirewallRule -Action Block -Enabled True 
	} else{ 
		Write-Host "No hay reglas definidas aún" 
	} 
}
break}


#Opcion 6, Agregar-ReglasBloqueo
6 {
	function Agregar-ReglasBloqueo{ 
	$puerto = Read-Host -Prompt "Cuál puerto quieres bloquear?" 
	New-NetFirewallRule -DisplayName "Puerto-Entrada-$puerto" -Profile "Public" -Direction Inbound -Action Block -Protocol TCP -LocalPort $puerto 

}
break} 


#Opcion 7, Eliminar-ReglasBloqueo
7 {
	function Eliminar-ReglasBloqueo{ 
	$reglas = Get-NetFirewallRule -Action Block -Enabled True 
	Write-Host "Reglas actuales" 
	foreach($regla in $reglas){ 
		Write-Host "Regla:" $regla.DisplayName 
		Write-Host "Perfil:" $regla.Profile 
		Write-Host "ID:" $regla.Name 
		$opc = Read-Host -Prompt "Deseas eliminar esta regla [Y] Si [N] No" 
		if($opc -eq "Y"){ 
			Remove-NetFirewallRule -ID $regla.name 
			break 
		} 
	} 
}
break}


}} until($entrada -eq 8 )
