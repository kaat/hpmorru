<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

$null = new-item "./export/html" -type directory -force

copy "./markdown.css" -destination "./export/html/"
copy "./markdown.css" -destination "./export/"

# html по главам
dir "./parts" -filter "*.md" | % {
   $output = "./export/html/" + $_.Name + ".html"
   $output
   pandoc --from=markdown --smart --standalone --self-contained --css=markdown.css --output=$output $_.FullName
}

"to epub..."; pandoc --from=markdown --smart --output=export/hpmor_ru.epub --epub-cover-image=images/cover.jpg "./export/hpmor_ru.md"
# "to pdf..."; pandoc --from=markdown --to=pdf --output=export/hpmor_ru.pdf "./export/hpmor_ru.md"

"to html..."; pandoc --from=markdown --smart --standalone --self-contained --css=markdown.css --output=export/hpmor_ru.html "./export/hpmor_ru.md"
$content = [System.IO.File]::ReadAllText("./export/hpmor_ru.html")
$content = $content.Replace("./images/", "../images/")
$content | Out-File "./export/hpmor_ru.html"

"to fb2..."; pandoc --from=markdown --smart --output=export/hpmor_ru.fb2 "./export/hpmor_ru.md"
"to docx..."; pandoc --from=markdown --smart --output=export/hpmor_ru.docx "./export/hpmor_ru.md"
"to mobi..."; pandoc --from=markdown --smart --output=export/hpmor_ru.mobi "./export/hpmor_ru.md"

"Export completed!"

# read-host