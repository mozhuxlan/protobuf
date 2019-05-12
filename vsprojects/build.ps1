$clpath = (get-command cl -ErrorAction SilentlyContinue)
if (-not $clpath) {
	Write-Warning "Please run in a Visual Studio x86 or 'x64_x86' Command Prompt"
	return 1
}

$slnpath = (gi "protobuf.sln").FullName

#& devenv "`"$slnpath`"" /Upgrade

& msbuild /m $slnpath /p:configuration="debug" /p:platform="Win32" /t:libprotobuf
if ($?) {
	& msbuild /m $slnpath /p:configuration="release" /p:platform="Win32" /t:libprotobuf
}
if ($?) {
	& ./extract_includes.bat
}
