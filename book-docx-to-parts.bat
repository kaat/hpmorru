<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

function Query-YN($prompt) {
   $v = read-host -prompt $prompt
   if($v.ToLowerInvariant() -eq "y") { return $true }
   if($v.ToLowerInvariant() -eq "n") { return $false }
   return Query-YN $prompt
}

"`n 1. Очищаем содержимое папки 'parts'..."
if(test-path('./parts')) { dir "./parts" | % { del -path $_.FullName -force -recurse } }

# "`n 2. Конвертируем доп. материалы в markdown..."
# &"./DocConvert.exe" --path_in "./docx_include" --path_out "./parts" --verbose --resources "./parts/resources" --resourcesRel "./resources" 

"`n 3. Конвертируем главы в markdown..."
$yn = Query-YN "    С картиночками? [y/n]"
if($yn -eq 'y') {
   &"./DocConvert.exe" --path_in "./docx" --path_out "./parts" --verbose --resources "./parts/resources" --resourcesRel "./parts/resources" --include_images
} else {
   &"./DocConvert.exe" --path_in "./docx" --path_out "./parts" --verbose --resources "./parts/resources" --resourcesRel "./parts/resources"
}

"`n 4. Копируем доп. материалы в формате markdown..."
dir "./parts_include" -filter "*.md" |
% { copy-item $_.FullName -destination "./parts" -force }