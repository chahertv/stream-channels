param([string]$TMP_J, [string]$TMP_V)
try {
    $j = Get-Content $TMP_J -Raw -Encoding UTF8 | ConvertFrom-Json
    $b = $j.bat
    $lines = New-Object System.Collections.Generic.List[string]

    $lines.Add("SET TC=" + $j.channels.Count)
    $lines.Add("SET B_COLOR_MAIN=" + $b.color_main)
    $lines.Add("SET B_COLOR_PLAYER=" + $b.color_player)
    $lines.Add("SET B_TITLE_MAIN=" + $b.title_main)
    $lines.Add("SET B_TITLE_PLAYER=" + $b.title_player)
    $lines.Add("SET B_LINE1=" + $b.header_line1)
    $lines.Add("SET B_LINE2=" + $b.header_line2)
    $lines.Add("SET B_LINE3=" + $b.header_line3)
    $lines.Add("SET B_MENU_HEADER=" + $b.menu_header)
    $lines.Add("SET B_PROMPT=" + $b.prompt_msg)
    $lines.Add("SET B_INVALID=" + $b.invalid_msg)
    $lines.Add("SET B_LAUNCHING=" + $b.launching_msg)
    $lines.Add("SET B_PLAYER_HDR=" + $b.player_header)
    $lines.Add("SET B_PLAYER_STS=" + $b.player_status)
    $lines.Add("SET B_PLAYER_FTR=" + $b.player_footer)
    $lines.Add("SET B_BYE1=" + $b.bye_line1)
    $lines.Add("SET B_BYE2=" + $b.bye_line2)
    $lines.Add("SET B_BYE3=" + $b.bye_line3)
    $lines.Add("SET B_FOOTER=" + $b.footer_line)
    $lines.Add("SET B_OFFLINE=" + $b.offline_label)
    $lines.Add("SET B_CHAN_OFF=" + $b.channel_offline_msg)
    $lines.Add("SET B_ERROR=" + $b.error_msg)

    $i = 1
    foreach ($c in $j.channels) {
        $lines.Add("SET N" + $i + "=" + $c.name)
        $lines.Add("SET U" + $i + "=" + $c.url)
        $lines.Add("SET X" + $i + "=" + $(if ($c.active) { "1" } else { "0" }))
        $i++
    }

    [IO.File]::WriteAllLines($TMP_V, $lines, [Text.Encoding]::UTF8)
    exit 0
} catch {
    exit 1
}

