<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

"`n 1. Исправляем содержимое папки 'parts', различные двойные звёздочки и прочее..."
cd parts
# get-childitem *.md | foreach { rename-item $_ ($_.Name -Replace(" ","_")) }
get-childitem *.md | foreach { rename-item $_ ($_.Name -Replace("([^a-zA-Z_ 0-9.])","$1")) }
get-childitem *.md | foreach { sed -i -f ../book-repair-asterix.sed $_  }
cd ..
