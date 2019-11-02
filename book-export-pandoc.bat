<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

if(test-path("C:/Users/yuliyl/AppData/Local/Pandoc/pandoc.exe")) {
   $pandoc = "C:/Users/yuliyl/AppData/Local/Pandoc/pandoc.exe"
} else {
   $pandoc = "pandoc.exe"
}

$7z = "C:/Program Files (x86)/7-Zip/7z.exe"
$css = "./images/markdown.css"
$name = "hpmor_ru"

if(test-path("./export/html/")) { $null = remove-item "./export/html/" -force -recurse }
$null = new-item "./export/html/" -type directory -force

copy "./images/*.css" -destination "./export/html/"
copy "./images/*.css" -destination "./export/"

# "Конвертируем в HTML по главам..."
# @(dir "./parts" -filter "*.md") +
# @(dir "./parts_include" -filter "*.md") +
# @(dir "./parts_include_pandoc" -filter "*.md") |
# % {
#    "  * $($_.Name)"
#    $output = "./export/html/" + $_.Name + ".html"
#    &$pandoc --from=markdown --smart -V lang:russian --standalone --self-contained --css=$css --output=$output $_.FullName
# }

# "Конвертируем в EPUB..."
# &$pandoc --from=markdown --smart -V lang:russian --output="./export/$name.epub" --epub-cover-image=# images/cover.jpg "./export/$name.md"
# "Конвертируем в PDF..."
# &$pandoc --from=markdown --to=pdf --output="./export/$name.pdf" "./export/$name.md"

"Конвертируем в HTML..."
&$pandoc --from=markdown -V lang:ru-ru --metadata pagetitle="Гарри Поттер и методы рационального мышления" --standalone --self-contained --css=$css --output="./export/$name.html" "./export/$name.md"
$content = [System.IO.File]::ReadAllText("./export/$name.html")
$content = $content.Replace("./images/", "../images/")
$content | Out-File "./export/$name.html"

#"Конвертируем в FB2..."
#&$pandoc --from=markdown --smart -V lang:russian --output="./export/$name.fb2" "./export/$name.md"
#"  * Архивируем FB2..."
#if(test-path($7z)) {
#   &$7z a -tzip -mx9 "./export/$name.fb2.zip" "./export/$name.fb2" 
#} else {
#   zip -9 -m -D -j "./export/$name.fb2.zip" "./export/$name.fb2"
#}

"Конвертируем в DOCX..."
&$pandoc --from=markdown -V lang:ru-ru --output="./export/$name.docx" "./export/$name.md"
# "Конвертируем в MOBI..."
# &$pandoc --from=markdown --smart -V lang:russian --output="./export/$name.mobi" "./export/$name.md"