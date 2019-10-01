$BuildFolder = $PSScriptRoot

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore
if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
	Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
	Import-Module PowerShellGet -Force
}

Set-Location $BuildFolder

$OutputPath = "$BuildFolder\output\UniversalDashboard.SyntaxHighlighter"

Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
Remove-Item -Path "$BuildFolder\public" -Force -ErrorAction SilentlyContinue -Recurse

New-Item -Path $OutputPath -ItemType Directory

npm install
npm run build

Copy-Item $BuildFolder\public\*.bundle.js $OutputPath
Copy-Item $BuildFolder\public\*.map $OutputPath
Copy-Item $BuildFolder\UniversalDashboard.SyntaxHighlighter.psm1 $OutputPath

$Version = "1.0.0"

$manifestParameters = @{
	Path = "$OutputPath\UniversalDashboard.SyntaxHighlighter.psd1"
	Author = "Adam Driscoll"
	CompanyName = "Ironman Software, LLC"
	Copyright = "2019 Ironman Software, LLC"
	RootModule = "UniversalDashboard.SyntaxHighlighter.psm1"
	Description = "Syntax Highlighter for Universal Dashboard."
	ModuleVersion = $version
	Tags = @("universaldashboard", "SyntaxHighlighter", "ud-control")
	ReleaseNotes = "Initial release"
	FunctionsToExport = @(
		"New-UDSyntaxHighlighter"
	)
	IconUri = "https://github.com/ironmansoftware/ud-syntaxhighlighter/raw/master/images/screenshot.png"
	ProjectUri = "https://github.com/ironmansoftware/ud-syntaxhighlighter"
  RequiredModules = @()
}

New-ModuleManifest @manifestParameters 

if ($prerelease -ne $null) {
	Update-ModuleManifest -Path "$OutputPath\UniversalDashboard.SyntaxHighlighter.psd1" -Prerelease $prerelease
}

