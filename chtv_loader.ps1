$cfg_url = "https://raw.githubusercontent.com/chahertv/stream-channels/main/config.json"
$chs_url = "https://raw.githubusercontent.com/chahertv/stream-channels/main/channels.json"
$out = "$env:TEMP\chtv_vars.bat"

$c = Invoke-WebRequest $cfg_url -UseBasicParsing | ConvertFrom-Json
$h = Invoke-WebRequest $chs_url -UseBasicParsing | ConvertFrom-Json
$b = $c.bat

$lines = @()
$lines += "SET C="   + $b.color_main
$lines += "SET CP="  + $b.color_player
$lines += "SET T="   + $b.title_main
$lines += "SET TP="  + $b.title_player
$lines += "SET L1="  + $b.header_line1
$lines += "SET L2="  + $b.header_line2
$lines += "SET L3="  + $b.header_line3
$lines += "SET MH="  + $b.menu_header
$lines += "SET PM="  + $b.prompt_msg
$lines += "SET IV="  + $b.invalid_msg
$lines += "SET LM="  + $b.launching_msg
$lines += "SET PH="  + $b.player_header
$lines += "SET PS2=" + $b.player_status
$lines += "SET PF="  + $b.player_footer
$lines += "SET B1="  + $b.bye_line1
$lines += "SET B2="  + $b.bye_line2
$lines += "SET B3="  + $b.bye_line3
$lines += "SET FT="  + $b.footer_line
$lines += "SET TC="  + $h.channels.Count

$i = 1
foreach ($ch in $h.channels) {
    $lines += "SET N" + $i + "=" + $ch.name
    $lines += "SET U" + $i + "=" + $ch.url
    $lines += "SET X" + $i + "=" + $(if ($ch.active) {"1"} else {"0"})
    $i++
}

[System.IO.File]::WriteAllLines($out, $lines, [System.Text.Encoding]::UTF8)
Write-Host "OK"
