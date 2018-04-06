<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

# if(test-path("C:/Users/yuliyl.EA/AppData/Local/Pandoc/pandoc.exe")) {
#    $pandoc = "C:/Users/yuliyl.EA/AppData/Local/Pandoc/pandoc.exe"
# } else {
#    $pandoc = "pandoc.exe"
# }

$calibre = "C:/Program Files (x86)/Calibre2/ebook-convert.exe"

$7z = "C:/Program Files/7-Zip/7z.exe"
# $css = "./images/markdown.css"

# if(test-path("./export/html/")) { $null = remove-item "./export/html/" -force -recurse }
# $null = new-item "./export/html/" -type directory -force

# copy "./images/*.css" -destination "./export/html/"
# copy "./images/*.css" -destination "./export/"

# "Конвертируем в HTML по главам..."
# dir "./parts" -filter "*.md" | % {
#    "  * $($_.Name)"
#    $output = "./export/html/" + $_.Name + ".html"
#    &$pandoc --from=markdown --smart -V lang:russian --standalone --self-contained --css=$css --output=$output $_.FullName
# }

del export/hpmor_ru.epub
del export/hpmor_ru.fb2.zip
del export/hpmor_ru.mobi

# "Конвертируем в EPUB..."
&$calibre ./export/hpmor_ru_calibre.md export/hpmor_ru.epub --input-encoding utf-8 --cover images/cover.jpg --read-metadata-from-opf images/content.opf --use-auto-toc --level1-toc //h:h2 --chapter //h:h2 -v

# &$pandoc --from=markdown --smart -V lang:russian --output=export/hpmor_ru.epub --epub-cover-image=images/cover.jpg "./export/hpmor_ru.md"
# # "Конвертируем в PDF..."
# # &$pandoc --from=markdown --to=pdf --output=export/hpmor_ru.pdf "./export/hpmor_ru.md"

# "Конвертируем в HTML..."
# &$pandoc --from=markdown --smart -V lang:russian --standalone --self-contained --css=$css --output=export/hpmor_ru.html "./export/hpmor_ru.md"
# $content = [System.IO.File]::ReadAllText("./export/hpmor_ru.html")
# $content = $content.Replace("./images/", "../images/")
# $content | Out-File "./export/hpmor_ru.html"

# "Конвертируем в FB2..."
&$calibre ./export/hpmor_ru_calibre.md export/hpmor_ru.fb2 --input-encoding utf-8 --cover images/cover.jpg --read-metadata-from-opf images/content.opf --use-auto-toc --level1-toc //h:h2 --chapter //h:h2 -v --fb2-genre sf_fantasy -v --sectionize toc


# &$pandoc --from=markdown --smart -V lang:russian --output=export/hpmor_ru.fb2 "./export/hpmor_ru.md"
# "  * Архивируем FB2..."
if(test-path($7z)) {
    &$7z a -tzip -mx9 "./export/hpmor_ru.fb2.zip" "./export/hpmor_ru.fb2" 
} else {
   zip -9 -m -D -j "./export/hpmor_ru.fb2.zip" "./export/hpmor_ru.fb2"
}
# "Конвертируем в DOCX..."
# &$pandoc --from=markdown --smart -V lang:russian --output=export/hpmor_ru.docx "./export/hpmor_ru.md"
# "Конвертируем в MOBI..."
# &$pandoc --from=markdown --smart -V lang:russian --output=export/hpmor_ru.mobi "./export/hpmor_ru.md"

&$calibre ./export/hpmor_ru_calibre.md export/hpmor_ru.mobi --input-encoding utf-8 --cover images/cover.jpg --read-metadata-from-opf images/content.opf --use-auto-toc --level1-toc //h:h2 --chapter //h:h2 -v

del export/hpmor_ru.fb2