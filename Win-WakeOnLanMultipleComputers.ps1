# WakeOnLan using a comma separated list of mac addresses 
# $macAddrs = "ee:ee:ee:ee:ee:ee,ff:ff:ff:ff:ff:ff"

# Exit if macAddrs variable is empty 
if (!$env:macAddrs){
	Write-Host 'Variable "macAddrs" empty.'
	Write-Host "This should contain a comma separated list of mac addresses"
	Exit
}

# Convert comma separated list of mac addresses into an array
$macArray = $env:macAddrs.Split(",")

# Send a magic packet using each mac address in the array
for($i=0;$i -lt $macArray.Length; $i++){
	# Sending 5 magic packets to be safe
	for($x=0;$x -lt 5; $x++){
		# Converting the address into a byte array. EE --> 0xEE 
		$macByteArray = $macArray[$i] -split "[:-]" | ForEach-Object { [Byte] "0x$_"}
		# Constructing our magic packet. Six FF bytes followed by sixteen instances of the mac address bytes
		[Byte[]] $magicPacket = (,0xFF * 6) + ($macByteArray  * 16)

		# Creating a UDP client object
		$UdpClient = New-Object System.Net.Sockets.UdpClient
		# Sending the magic packet to the broadcast address
		$UdpClient.Connect(([System.Net.IPAddress]::Broadcast),7)
		$UdpClient.Send($magicPacket,$magicPacket.Length)
		$UdpClient.Close()
	}
}