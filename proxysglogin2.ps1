##Script to display expiration date of ABRCA_Root CA in every ProxySG
cls
echo "`n"
echo "This is a simple powershell script to extract certificate details of Symantec's ABRCA Root Details"

$ASAUser = Read-Host -Prompt 'Input the user name'
$securePwd = Read-Host "Enter password" -AsSecureString
$ASApw =[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePwd))
#Write-Host "You password is : $ASApw" -ForegroundColor Yellow
$ASAEnablepw = $ASApw

#$Server = Read-Host -Prompt 'Input your server  name' 
#$Enablepw = $securePwd
#$ProxyIP = "192.168.1.141"

#Display Validity of ABRCA_Root
#Starts by writing a "commands" file#
echo en >>unicode.txt
echo $ASAEnablepw >>unicode.txt
echo "show hostname" >>unicode.txt
echo "show ssl summary ca-certificate ABRCA_root" >>unicode.txt
echo exit >>unicode.txt
echo exit >>unicode.txt

 
#Converts the file to ASCII format (separate file)#
$lines = gc "unicode.txt"
$lines | out-file -encoding Ascii -filepath commands.txt

Write-Output "Script Executed at $(Get-Date)" >output.txt

foreach($line in [System.IO.File]::ReadLines("C:\Users\Rich\Google Drive\Techinfo\PowerShell\scripts\proxysgcaservices\proxylist.txt"))
   {
      #Using the command file and plink.exe connects and runs the commands #
        echo "Connecting to $line ..."
        echo yes | ./plink.exe -ssh -l $ASAUser -pw $ASApw $line  -m commands.txt  >>output.txt
		echo "Done"
		echo "`n"
      #removes the files it created earlier#
     }

Write-Output "Completed at $(Get-Date)" >>output.txt
type output.txt
del unicode.txt
del commands.txt
