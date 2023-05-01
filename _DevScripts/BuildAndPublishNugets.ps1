# https://go.microsoft.com/fwlink/?LinkID=135170
# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

dotnet restore "..\src"
dotnet build "..\src" --configuration Release --no-restore

$NuGetFiles = Get-ChildItem -Path "..\src\**\bin\Release" -Filter "*.nupkg" -Recurse -ErrorAction SilentlyContinue -Force

New-Item -Path "..\" -Name "publish" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

foreach ($file in $NuGetFiles)
{
    Copy-Item $file -Destination "..\publish"
}
