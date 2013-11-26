<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

if(test-path("./export/hpmor_ru.md")) {
	del "./export/hpmor_ru.md"
}

$code_regex = new-object Regex "^(\d+)\s+.*$"

dir "./parts" -filter "*.md" |
sort {
   $rr = $code_regex.Match($_.Name)
   if($rr.Success) {
      [int]$rr.Groups[1].Value
   }
   else {
      -1 # все кривые коды будут вверху
   }
} |
% {
	$_.Name
	$content = get-content $_.FullName
	add-content -value $content -path "./export/hpmor_ru.md" -encoding "UTF8"
}