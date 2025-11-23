# Base folder for all media & configs
$base = "E:\media-servarr"

# Media folders (shared between Plex/Jellyfin and apps)
$mediaFolders = @("media\tv", "media\movies", "media\music", "downloads")

# Config folders for each app
$configFolders = @(
    "plex\config",
    "jellyfin\config",
    "jellyfin\cache",
    "jellyseerr\config",
    "sonarr\config",
    "radarr\config",
    "lidarr\config",
    "prowlarr\config",
    "bazarr\config",
    "sabnzbd\config",
    "qbittorrent\config",
    "flaresolverr\config",
    "adguard\work",
    "adguard\conf",
    "calibre\config",
    "calibre\library",
    "decluttarr\config",
    "tandoor\config",
    "joplin\config",
    "homeassistant\config",
    "immich\config",
    "vaultwarden\config"
)

# Create media folders
foreach ($folder in $mediaFolders) {
    $path = Join-Path $base $folder
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force
        Write-Host "Created folder: $path"
    }
}

# Create config folders
foreach ($folder in $configFolders) {
    $path = Join-Path $base $folder
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force
        Write-Host "Created folder: $path"
    }
}

Write-Host "All folders created successfully."
