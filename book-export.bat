<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
@pause
@goto :EOF
#>

$pandoc = "C:\Users\yuliyl.EA\AppData\Local\Pandoc\pandoc.exe" # переменная для полного пути к pandoc, требуется, если путь к нему не находится в Env:Path
$7z = "C:\Program Files (x86)\7-Zip\7z.exe"

if(test-path("./export/html/")) { $null = remove-item "./export/html/" -force -recurse }
$null = new-item "./export/html/" -type directory -force

copy "./markdown.css" -destination "./export/html/"
copy "./markdown.css" -destination "./export/"

"Конвертируем в HTML по главам..."
dir "./parts" -filter "*.md" | % {
   "  * $($_.Name)"
   $output = "./export/html/" + $_.Name + ".html"
   &$pandoc --from=markdown --smart --standalone --self-contained --css=markdown.css --output=$output $_.FullName
}

"Конвертируем в EPUB..."
&$pandoc --from=markdown --smart --output=export/hpmor_ru.epub --epub-cover-image=images/cover.jpg "./export/hpmor_ru.md"
# "Конвертируем в PDF..."
# &$pandoc --from=markdown --to=pdf --output=export/hpmor_ru.pdf "./export/hpmor_ru.md"

"Конвертируем в HTML..."
&$pandoc --from=markdown --smart --standalone --self-contained --css=markdown.css --output=export/hpmor_ru.html "./export/hpmor_ru.md"
$content = [System.IO.File]::ReadAllText("./export/hpmor_ru.html")
$content = $content.Replace("./images/", "../images/")
$content | Out-File "./export/hpmor_ru.html"

"Конвертируем в FB2..."
&$pandoc --from=markdown --smart --output=export/hpmor_ru.fb2 "./export/hpmor_ru.md"
&$7z a -tzip -mx9 "./export/hpmor_ru.fb2.zip" "./export/hpmor_ru.fb2" # делаем архив
"Конвертируем в DOCX..."
&$pandoc --from=markdown --smart --output=export/hpmor_ru.docx "./export/hpmor_ru.md"
"Конвертируем в MOBI..."
&$pandoc --from=markdown --smart --output=export/hpmor_ru.mobi "./export/hpmor_ru.md"