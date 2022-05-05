# Usage
It takes an environmental variable with a comma separated list of mac addresses.
The script constructs a WOL packet and sends it to each mac address five times

~~~ powershell
$macAddrs = "ee:ee:ee:ee:ee:ee,ff:ff:ff:ff:ff:ff"
./wake-on-lan-multiple-computers.ps1
~~~