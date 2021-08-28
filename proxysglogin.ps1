$ASApw = "Password123"
$ASAIP = "192.168.1.141"
$ASAUser = "admin"
$ASAEnablepw = $ASApw


#$User = Read-Host -Prompt 'Input the user name'
#$securePwd = Read-Host "Enter password for admin" -AsSecureString
#$Server = Read-Host -Prompt 'Input your server  name' 
#$Enablepw = $securePwd
#$ProxyIP = "192.168.1.141"

#Modifies the ASA firewall
#Starts by writing a "commands" file#
echo en >>unicode.txt
echo $ASAEnablepw >>unicode.txt
echo "show ssl summary ca-certificate ABRCA_root" >>unicode.txt
echo exit >>unicode.txt
echo exit >>unicode.txt
echo "\n\c" >>unicode.txt


echo "show hostname" >output.txt

 
#Converts the file to ASCII format (separate file)#
$lines = gc "unicode.txt"
$lines | out-file -encoding Ascii -filepath commands.txt
 
#Using the command file and plink.exe connects and runs the commands #
./plink.exe -ssh -l $ASAUser -pw $ASAEnablepw $ASAIP  -m commands.txt -batch >>output.txt

type output.txt
 
#removes the files it created earlier#
del unicode.txt
del commands.txt