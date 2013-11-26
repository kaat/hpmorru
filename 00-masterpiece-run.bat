<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

./book-docx-to-parts.bat
./book-join-parts.bat
./book-export.bat
./book-parts-to-feed.bat
./book-parts-check.bat # проверочка

# Даем возможность почитать логи
# read-host