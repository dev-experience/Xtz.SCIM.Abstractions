# https://go.microsoft.com/fwlink/?LinkID=135170
# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

# $NuGetApiToken = Get-Credential -UserName "NuGet.org API Token" -Message "Enter the token"
# ${Env:NugetOrg_ApiToken} = $NuGetApiToken.GetNetworkCredential().Password

$NuGetFiles = Get-ChildItem -Path "..\publish" -Filter "*.nupkg" -Recurse -ErrorAction SilentlyContinue -Force

New-Item -Path "..\" -Name "publish" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

foreach ($file in $NuGetFiles)
{
    Write-Output "${file.FullName}"
    dotnet nuget push $file.FullName --api-key "${Env:NugetOrg_ApiToken}" --source "https://api.nuget.org/v3/index.json" --skip-duplicate
}
