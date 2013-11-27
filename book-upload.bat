<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
@pause
@goto :EOF
#>

# набросок сие есмь

$login = "ololo"
$secure_password = read-host -prompt "А введите-ка пароль" -AsSecureString

$ptr_password = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure_password)
$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto($ptr_password)
[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr_password)

$login
$password

&pscp -pw$secure_password "./export/hpmor_ru.fb2.zip" $login@hpmor.ru:/home/httpd/vhosts/hpmor.ru/httpdocs/files/hpmor_ru.fb2.zip
&pscp -pw$secure_password "./export/hpmor_ru.mobi" $login@hpmor.ru:/home/httpd/vhosts/hpmor.ru/httpdocs/files/hpmor_ru.mobi
&pscp -pw$secure_password "./export/hpmor_ru.epub" $login@hpmor.ru:/home/httpd/vhosts/hpmor.ru/httpdocs/files/hpmor_ru.epub
&pscp -pw$secure_password "./export/hpmor_ru.html" $login@hpmor.ru:/home/httpd/vhosts/hpmor.ru/httpdocs/files/hpmor_ru.html
&pscp -pw$secure_password "./export/hpmor-feed.xml" $login@hpmor.ru:/home/httpd/vhosts/hpmor.ru/httpdocs/files/hpmor-feed.xml
