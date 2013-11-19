<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

# 1. Очищаем содержимое папки 'parts'
if(test-path('./parts')) { dir "./parts" -filter "*.md" | % { del -path $_.FullName -force } }

# 2. Конвертируем содержимое папки 'docx' в markdown (по главам)
&"./DocConvert.exe" --path_in "./docx" --path_out "./parts" --verbose

# read-host