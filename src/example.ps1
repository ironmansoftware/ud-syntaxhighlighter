Import-Module UniversalDashboard
Import-Module "$PSScriptRoot/output/UniversalDashboard.SyntaxHighlighter/UniversalDashboard.SyntaxHighlighter.psd1"

$Dashboard = New-UDDashboard -Title "Syntax Highlighter" -Content {
    New-UDSyntaxHighlighter -Language PowerShell -Style dark -Code "Get-Process -Name 'code'"
}

Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force