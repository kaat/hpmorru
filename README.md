#﻿[HPMORRU](https://github.com/kaat/hpmorru/)

HPMOR RU command files

## Скрипты

Написаны на **bat-posh** и исполняются в Windows XP/Vista/7 - из коробки.

- `images` - статические ресурсы
- `parts_include` - статические главы (вступление, заключение и т.д.)
- `export` - эл. книги в различных форматах
- `00-masterpiece-run.bat`
- `book-docx-to-parts.bat` - превращает главы из `./docx` в главы `./parts`
- `book-join-parts.bat` - соединяет главы из `./parts` в книгу `./export/hpmor_ru.md`
- `book-export.bat` - экспортирует книгу `./hpmor_ru.md` из формата *markdown* в epub/fb2/html/docx средствами `pandoc`
- `book-parts-to-feed.bat`
- `DocConvert.exe`, `DocumentFormat.OpenXml.dll`
- `book-parts-check.bat`

## Workflow процесса сборки

![Процесс сборки](/images/process.png)

## RoadMap

- **Конвертор docx->md**
	- конвертация текста, выровненного вправо / по-центру
	- конвертация гиперссылок *@bug*
	- корректная конвертация таблиц *@option*
- **Общий стиль**
	- эпиграфы
- Доработки формирования `hpmor_feed.xml`
