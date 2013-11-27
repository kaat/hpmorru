<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
@pause
@goto :EOF
#>

$login = read-host -prompt "А введите-ка логин"
$secure_password = read-host -prompt "А введите-ка пароль" -AsSecureString
$ptr_password = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure_password)
$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto($ptr_password)
[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr_password)

&pscp -pw $password "./export/hpmor-feed.xml" $login@hpmor.ru:/home/httpd/vhosts/hpmor.ru/httpdocs/files/hpmor-feed.xml

# выгружаем результат работы pandoc
&pscp -pw $password "./export/hpmor_ru_pandoc.html" $login@hpmor.ru:/home/httpd/vhosts/hpmor.ru/httpdocs/files/hpmor_ru.html

# выгружаем результат работы calibre (!todo)
# &pscp -pw $password "./export/hpmor_ru_calibre.fb2.zip" $login@hpmor.ru:/home/httpd/vhosts/hpmor.ru/httpdocs/files/hpmor_ru.fb2.zip
# &pscp -pw $password "./export/hpmor_ru_calibre.mobi" $login@hpmor.ru:/home/httpd/vhosts/hpmor.ru/httpdocs/files/hpmor_ru.mobi
# &pscp -pw $password "./export/hpmor_ru_calibre.epub" $login@hpmor.ru:/home/httpd/vhosts/hpmor.ru/httpdocs/files/hpmor_ru.epub