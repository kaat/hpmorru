<# batch file posh loader
@cls
@powershell.exe -command "iex ([System.IO.File]::ReadAllText('%0'))"
:: @pause
@goto :EOF
#>

function Get-ChapterInfo($path) {
   $lines = [System.IO.File]::ReadAllText($_.fullname).Trim().Split("`n")
   
   $title = $lines | where { $_.StartsWith("#") } | % { $_.Replace("*", "").Replace("#", "").Trim() }
   $body = $lines | where { -not $_.StartsWith("#") }
   $code = "?"

   if(-not $title) { # этот хак нужен, пока не все заголовки оформлены нужным стилем
      $title = $lines[0].replace("*", "").replace("#", "").Trim()
   }

   $rr = $code_regex.Match($_.Name)
   if($rr.Success) {
      $code = [int]$rr.Groups[1].Value
   }

   return @{title=$title; body=$body; code=$code}
}

$code_regex = new-object Regex "^(\d+)\s+.*$"

$null = new-item "./export" -type directory -force
$feed_file = new-item './export/hpmor-feed.xml' -type file -force

$feed = "<book>`n"

dir './parts' -filter "*.md" |
# where { $_.FullName.contains("86") } | # debug filter
% {
   write-host "$($_.Name)..."
   $ci = Get-ChapterInfo $_.FullName

   if(($ci.code -le 0) -or ($ci.code -ge 2000)) { "  * skipping!"; return } # вступления и заключения в feed попадать не должны

   $feed += "  <chapter>`n"
   $feed += "    <code>book/1/$($ci.code)</code>`n"
   $feed += "    <title>$($ci.title)</title>`n"
   $feed += "    <content><![CDATA["
   $feed += [System.String]::Join("`n", $ci.body).Trim()
   $feed += "]]></content>`n"
   $feed += "  </chapter>`n"
}

$feed += "</book>"

$feed | out-file $feed_file -encoding "UTF8"

write-host "Press [enter] to exit..."; read-host