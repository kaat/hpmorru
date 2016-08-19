rem \*[^*]* \*

cd parts
rem for /r %%i in (*.md) do sed -f ../book-repair-asterix.sed "%%i"> "%%i.new"
for /r %%i in (*.md) do sed -i -f ../book-repair-asterix.sed "%%i"
cd ..
