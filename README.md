#﻿[HPMORRU](https://github.com/kaat/hpmorru/)

HPMOR RU command files

## Правила пользования лифтом

На данный момент содержимое сайта собирается из другого репозитория: <https://github.com/kaat/hpmorru-site>. Данный репозиторий сохраняется с историческими целями для сохранения правок, сделанных в документах Гугл и передачи их на сайт. Историю правок всего текста лучше всего смотреть по файлу [hpmor_ru_calibre.md](https://github.com/kaat/hpmorru/blob/master/export/hpmor_ru_calibre.md), также можно смотреть историю правок отдельных глав, но не такую глубокую, в другом репозитории [hpmorru-site](https://github.com/kaat/hpmorru-site/tree/master/content/book/1). Но предложения об исправлении всё также принимаются по почте <hp@hpmor.ru> с пометкой *правка*.

## Скрипты

Написаны на **bat-posh** и исполняются в Windows XP/Vista/7 - из коробки.

- `images` - статические ресурсы
- `parts_include` - общие статические главы (вступление, заключение и т.д.)
- `parts_include_pandoc` - статические главы - специфичные для [pandoc][l_pandoc]
- `parts_include_calibre` - статические главы - специфичные для [calibre][l_calibre]
- `export` - эл. книги в различных форматах, полученные с помощью скриптов
- `00-masterpiece-run.bat`
- `book-docx-to-parts.bat` - превращает главы из `./docx` в главы `./parts`
- `book-join-parts.bat` - соединяет главы в книгу `md`
- `book-export-pandoc.bat` - экспортирует книгу `./hpmor_ru_pandoc.md` из формата *markdown* в epub/fb2/html/docx средствами [pandoc][l_pandoc]
- `book-parts-to-feed.bat`
- `DocConvert.exe`, `DocumentFormat.OpenXml.dll`
- `book-parts-check.bat`


## RoadMap

- **Конвертор docx->md**
	- конвертация текста, выровненного вправо / по-центру
	- конвертация гиперссылок *@bug*
	- корректная конвертация таблиц *@option*
- **Общий стиль**
	- эпиграфы
- **Сайт [hpmor.ru](http://hpmor.ru/)**
	- скрипты загрузки данных по SSH

## Task Archive
- формировать файл hpmor_ru_pd.md из hpmor_ru.md добавлением к нему 0 заглавие.md, и этот файл использовать для pandoc *@done(2013-11-27)*

 [l_pandoc]: http://johnmacfarlane.net/pandoc/
 [l_calibre]: http://calibre-ebook.com/
