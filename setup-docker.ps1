# Media Servarr Docker Setup Script for Windows
# This script helps set up the Docker environment for your *arr services

Write-Host "🚀 Setting up Media Servarr Docker Environment..." -ForegroundColor Green

# Create necessary directories
Write-Host "📁 Creating directory structure..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "downloads"
New-Item -ItemType Directory -Force -Path "backups\lidarr\manual"
New-Item -ItemType Directory -Force -Path "backups\radarr\manual"
New-Item -ItemType Directory -Force -Path "backups\sonarr\manual"
New-Item -ItemType Directory -Force -Path "backups\readarr"
New-Item -ItemType Directory -Force -Path "backups\sabnzbd"
New-Item -ItemType Directory -Force -Path "backups\prowlarr"

# Check if network drives are mapped
Write-Host "🔍 Checking network drive mappings..." -ForegroundColor Yellow
$drives = @("D:", "M:", "N:", "P:", "T:", "B:")
$missingDrives = @()

foreach ($drive in $drives) {
    if (-not (Test-Path $drive)) {
        $missingDrives += $drive
    }
}

if ($missingDrives.Count -gt 0) {
    Write-Host "❌ Missing network drive mappings. Please run these commands first:" -ForegroundColor Red
    Write-Host ""
    Write-Host "net use D: \\PHOENIX\Data\Downloads /user:jeremy welcome" -ForegroundColor Cyan
    Write-Host "net use M: \\PHOENIX\Movies /user:jeremy welcome" -ForegroundColor Cyan
    Write-Host "net use N: \\PHOENIX\Music /user:jeremy welcome" -ForegroundColor Cyan
    Write-Host "net use P: \\PHOENIX\Photos /user:jeremy welcome" -ForegroundColor Cyan
    Write-Host "net use T: \\PHOENIX\tv /user:jeremy welcome" -ForegroundColor Cyan
    Write-Host "net use B: \\PHOENIX\Bookz /user:jeremy welcome" -ForegroundColor Cyan
    Write-Host ""
    exit 1
}

Write-Host "✅ Network drives are mapped" -ForegroundColor Green

# Start services
Write-Host "🐳 Starting Docker services..." -ForegroundColor Yellow
docker-compose up -d

Write-Host "🎉 Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Service URLs:" -ForegroundColor Cyan
Write-Host "  • Prowlarr (Indexer): http://localhost:9696" -ForegroundColor White
Write-Host "  • Radarr (Movies): http://localhost:7878" -ForegroundColor White
Write-Host "  • Sonarr (TV): http://localhost:8989" -ForegroundColor White
Write-Host "  • Readarr (Books): http://localhost:8787" -ForegroundColor White
Write-Host "  • Lidarr (Music): http://localhost:8686" -ForegroundColor White
Write-Host "  • Bazarr (Subtitles): http://localhost:6767" -ForegroundColor White
Write-Host "  • qBittorrent: http://localhost:8080" -ForegroundColor White
Write-Host "  • Jellyfin: http://localhost:8096" -ForegroundColor White
Write-Host "  • Jellyseerr: http://localhost:5055" -ForegroundColor White
Write-Host "  • AdGuard: http://localhost:3000" -ForegroundColor White
Write-Host "  • Vaultwarden: http://localhost:3012" -ForegroundColor White
Write-Host "  • Immich: http://localhost:2283" -ForegroundColor White
Write-Host "  • Home Assistant: http://localhost:8123" -ForegroundColor White
Write-Host "  • Joplin: http://localhost:22300" -ForegroundColor White
Write-Host "  • Tandoor: http://localhost:8081" -ForegroundColor White
Write-Host ""
Write-Host "🔧 Next steps:" -ForegroundColor Cyan
Write-Host "  1. Configure each service through their web interfaces" -ForegroundColor White
Write-Host "  2. Set up indexers in Prowlarr" -ForegroundColor White
Write-Host "  3. Configure download clients (qBittorrent)" -ForegroundColor White
Write-Host "  4. Set up media libraries in Jellyfin" -ForegroundColor White
Write-Host "  5. Configure Jellyseerr for request management" -ForegroundColor White
