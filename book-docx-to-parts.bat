<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

"`n 1. Очищаем содержимое папки 'parts'..."
if(test-path('./parts')) { dir "./parts" -filter "*.md" | % { del -path $_.FullName -force } }

# "`n 2. Конвертируем доп. материалы в markdown..."
# &"./DocConvert.exe" --path_in "./docx_include" --path_out "./parts" --verbose

"`n 3. Конвертируем главы в markdown..."
&"./DocConvert.exe" --path_in "./docx" --path_out "./parts" --verbose

"`n 4. Копируем доп. материалы в формате markdown..."
dir "./parts_include" -filter "*.md" |
% { copy-item $_.FullName -destination "./parts" -force }