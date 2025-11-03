# PowerShell-Skript zum Abrufen der GitHub-Follower eines Benutzers

# GitHub API URL für die Follower eines Benutzers
$baseUrl = "https://api.github.com/users/"

# Funktion zum Abrufen der Follower
function Get-GitHubFollowers {
    param (
        [string]$username
    )

    # Überprüfen, ob der Benutzername leer ist
    if (-not $username) {
        Write-Host "Bitte gib einen GitHub-Benutzernamen ein." -ForegroundColor Red
        return
    }

    $url = $baseUrl + $username + "/followers"

    try {
        # API-Anfrage an GitHub
        $response = Invoke-RestMethod -Uri $url -Headers @{ "User-Agent" = "PowerShell" }

        # Überprüfen, ob Follower vorhanden sind
        if ($response.Count -gt 0) {
            Write-Host "`nFollower von ${username}:`n" -ForegroundColor Green
            $response | ForEach-Object { Write-Host $_.login }
        }
        else {
            Write-Host "Keine Follower oder Fehler bei der Anfrage für den Benutzer $username." -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "Fehler beim Abrufen der Follower. Überprüfe den Benutzernamen oder versuche es später erneut." -ForegroundColor Red
    }
}

# Benutzereingabe
$username = Read-Host "Gib den GitHub-Benutzernamen ein"
Get-GitHubFollowers -username $username
