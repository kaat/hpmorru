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