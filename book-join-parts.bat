<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

if(test-path("./export/hpmor_ru.md")) {
	del "./export/hpmor_ru.md"
}

dir "./parts" | sort { $_.FullName } | 
foreach {
	$_.Name
	$content = get-content $_.FullName
	$content >> "./export/hpmor_ru.md"
}

"Joined!"

# read-host