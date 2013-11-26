<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

$code_regex = new-object Regex "^(\d+)\s+.*$"
$log = new-item "./book-parts-check.txt" -type file -force
$codes = @{}

"[Отсутствуют заголовки глав]" >> $log
dir './parts' -filter "*.md" |
# where { $_.FullName.contains("86") } | # debug filter
sort {
   $rr = $code_regex.Match($_.Name)
   if($rr.Success) {
      $code = [int]$rr.Groups[1].Value
      $codes[$code] += 1
      $code
   }
   else {
      "  [$($_.Name)] Не удалось получить код документа" >> $log
      -1 # все кривые коды будут вверху
   }
} |
% {
   "$($_.Name)..."
   $lines = [System.IO.File]::ReadAllText($_.fullname).Trim().Split("`n")
   if(-not ($lines | where { $_.StartsWith("#") })) {
      "  `"$($_.Name)`"" >> $log
      # $lines | where { $_.StartsWith("#") } | % { "    $($_.Trim())" } >> $log
   }
}

"[Повторяются коды документа]" >> $log
$codes.GetEnumerator() |
where { $_.Value -gt 1 } |
% { "  $($_.Name) - $($_.Value) шт." } >> $log

invoke-item $log