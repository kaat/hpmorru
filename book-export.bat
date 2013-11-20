<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
@pause
@goto :EOF
#>

$null = new-item "./export/html" -type directory -force

copy "./markdown.css" -destination "./export/html/"
copy "./markdown.css" -destination "./export/"

"Конвертируем в HTML по главам..."
dir "./parts" -filter "*.md" | % {
   "  * $($_.Name)"
   $output = "./export/html/" + $_.Name + ".html"
   C:\Users\yuliyl.EA\AppData\Local\Pandoc\pandoc.exe --from=markdown --smart --standalone --self-contained --css=markdown.css --output=$output $_.FullName
}

"Конвертируем в EPUB..."
C:\Users\yuliyl.EA\AppData\Local\Pandoc\pandoc.exe --from=markdown --smart --output=export/hpmor_ru.epub --epub-cover-image=images/cover.jpg "./export/hpmor_ru.md"
# "Конвертируем в PDF..."
# C:\Users\yuliyl.EA\AppData\Local\Pandoc\pandoc.exe --from=markdown --to=pdf --output=export/hpmor_ru.pdf "./export/hpmor_ru.md"

"Конвертируем в HTML..."
C:\Users\yuliyl.EA\AppData\Local\Pandoc\pandoc.exe --from=markdown --smart --standalone --self-contained --css=markdown.css --output=export/hpmor_ru.html "./export/hpmor_ru.md"
$content = [System.IO.File]::ReadAllText("./export/hpmor_ru.html")
$content = $content.Replace("./images/", "../images/")
$content | Out-File "./export/hpmor_ru.html"

"Конвертируем в FB2..."
C:\Users\yuliyl.EA\AppData\Local\Pandoc\pandoc.exe --from=markdown --smart --output=export/hpmor_ru.fb2 "./export/hpmor_ru.md"
zip -9 -m -D -j "./export/hpmor_ru.fb2.zip" "./export/hpmor_ru.fb2" # делаем архив
"Конвертируем в DOCX..."
C:\Users\yuliyl.EA\AppData\Local\Pandoc\pandoc.exe --from=markdown --smart --output=export/hpmor_ru.docx "./export/hpmor_ru.md"
"Конвертируем в MOBI..."
C:\Users\yuliyl.EA\AppData\Local\Pandoc\pandoc.exe --from=markdown --smart --output=export/hpmor_ru.mobi "./export/hpmor_ru.md"

"Export completed!"

# read-host