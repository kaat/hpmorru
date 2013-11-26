<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

function Wait-Timeout($timeout, $delta=50) {
	$v = 0
	while($v -Lt $timeout) {
		write-host "." -NoNewLine
		start-sleep -Milliseconds $delta
		if($host.UI.RawUI.KeyAvailable) {
			return $false
		}
		$v += $delta
	}
	return $true
}

function Query-YN($prompt, $timeout, $default) {
	write-host "$prompt (жду '$timeout' мс)..."
	$is_timeout = Wait-Timeout $timeout
	if($is_timeout) {
		$v = $default
		write-host "`nИспользую дефолт: $v"
	} else {
		$v = read-host -prompt "`n$prompt"
	}

	if($v.ToLowerInvariant() -Eq "y") { return $true }
	if($v.ToLowerInvariant() -Eq "n") { return $false }
	return Query-YN $prompt $timeout $default
}

"`n 1. Очищаем содержимое папки 'parts'..."
if(test-path('./parts')) { dir "./parts" | % { del -path $_.FullName -force -recurse } }

"`n 2. Конвертируем главы в markdown..."
$yn = Query-YN "    С картиночками? [y/n]" -timeout 3500 -default "n"
if($yn -eq 'y') {
	&"./DocConvert.exe" --path_in "./docx" --path_out "./parts" --verbose --resources "./parts/resources" --resourcesRel "./parts/resources" --include_images
} else {
	&"./DocConvert.exe" --path_in "./docx" --path_out "./parts" --verbose --resources "./parts/resources" --resourcesRel "./parts/resources"
}

"`n 3. Копируем доп. материалы в формате markdown..."
dir "./parts_include" -filter "*.md" |
% { copy-item $_.FullName -destination "./parts" -force }