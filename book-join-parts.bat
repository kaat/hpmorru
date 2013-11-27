<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

if(test-path("./export/hpmor_ru_pandoc.md"))  { del "./export/hpmor_ru_pandoc.md" }
if(test-path("./export/hpmor_ru_calibre.md")) { del "./export/hpmor_ru_calibre.md" }

$code_regex = new-object Regex "^(\d+)\s+.*$"

function book-join($path1, $path2, $path3, $result) {
   "Объединяем части в $result..."
   @(dir $path1 -filter "*.md") +
   @(dir $path2 -filter "*.md") +
   @(dir $path3 -filter "*.md") |
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
   	"  * $($_.Name)"
   	$content = get-content $_.FullName
   	add-content -value $content -path $result -encoding "UTF8"
   }
}

book-join "./parts" "./parts_include" "./parts_include_pandoc"  "./export/hpmor_ru_pandoc.md"
book-join "./parts" "./parts_include" "./parts_include_calibre" "./export/hpmor_ru_calibre.md"