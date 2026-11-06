param([Parameter(Mandatory=$true)][string]$Url)
$ErrorActionPreference = 'Stop'
$address = [Uri]$Url
if ($address.Scheme -ne 'https' -or $address.UserInfo -or $address.Query -or $address.Fragment -or $address.AbsolutePath -ne '/') { throw 'Pass the HTTPS root address, for example https://voltaris-auth.onrender.com/' }
$health = $Url.TrimEnd('/') + '/healthz'
$deadline = (Get-Date).AddSeconds(120)
do {
    try {
        $response = Invoke-WebRequest -Uri $health -TimeoutSec 8 -UseBasicParsing
        if ($response.StatusCode -eq 200 -and $response.Content.Trim() -eq 'ok') { Write-Output 'Backend is ready. Authorization endpoint:'; Write-Output ($Url.TrimEnd('/') + '/v1/authorize'); exit 0 }
    } catch {}
    Start-Sleep -Seconds 2
} while ((Get-Date) -lt $deadline)
throw 'Backend did not become ready. Check the deployment log and the secret setting.'
