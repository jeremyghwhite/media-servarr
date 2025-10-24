#!/bin/bash

# Media Servarr Docker Setup Script
# This script helps set up the Docker environment for your *arr services

echo "🚀 Setting up Media Servarr Docker Environment..."

# Create necessary directories
echo "📁 Creating directory structure..."
mkdir -p downloads
mkdir -p backups/{lidarr,radarr,sonarr,readarr,sabnzbd,prowlarr}/{manual,automatic}

# Set proper permissions
echo "🔐 Setting permissions..."
sudo chown -R 1000:1000 .

# Check if network drives are mounted
echo "🔍 Checking network drive mounts..."
if [ ! -d "/media-servarr/media/phoenix_movies" ]; then
    echo "❌ Network drives not mounted. Please run the WSL mount commands first:"
    echo ""
    echo "sudo mkdir -p /media-servarr/media/phoenix_movies"
    echo "sudo mount -t drvfs '\\\\PHOENIX\\Movies' /media-servarr/media/phoenix_movies"
    echo "sudo mkdir -p /media-servarr/media/phoenix_tv"
    echo "sudo mount -t drvfs '\\\\PHOENIX\\tv' /media-servarr/media/phoenix_tv"
    echo "sudo mkdir -p /media-servarr/media/phoenix_music"
    echo "sudo mount -t drvfs '\\\\PHOENIX\\Music' /media-servarr/media/phoenix_music"
    echo "sudo mkdir -p /media-servarr/media/phoenix_books"
    echo "sudo mount -t drvfs '\\\\PHOENIX\\Bookz' /media-servarr/media/phoenix_books"
    echo "sudo mkdir -p /media-servarr/media/phoenix_photos"
    echo "sudo mount -t drvfs '\\\\PHOENIX\\Photos' /media-servarr/media/phoenix_photos"
    echo "sudo mkdir -p /media-servarr/media/phoenix_downloads"
    echo "sudo mount -t drvfs '\\\\PHOENIX\\Data\\Downloads' /media-servarr/media/phoenix_downloads"
    echo ""
    exit 1
fi

echo "✅ Network drives are mounted"

# Start services
echo "🐳 Starting Docker services..."
docker-compose up -d

echo "🎉 Setup complete!"
echo ""
echo "📋 Service URLs:"
echo "  • Prowlarr (Indexer): http://localhost:9696"
echo "  • Radarr (Movies): http://localhost:7878"
echo "  • Sonarr (TV): http://localhost:8989"
echo "  • Readarr (Books): http://localhost:8787"
echo "  • Lidarr (Music): http://localhost:8686"
echo "  • Bazarr (Subtitles): http://localhost:6767"
echo "  • qBittorrent: http://localhost:8080"
echo "  • SABnzbd: http://localhost:8080 (if using instead of qBittorrent)"
echo "  • Jellyfin: http://localhost:8096"
echo "  • Jellyseerr: http://localhost:5055"
echo "  • AdGuard: http://localhost:3000"
echo "  • Vaultwarden: http://localhost:3012"
echo "  • Immich: http://localhost:2283"
echo "  • Home Assistant: http://localhost:8123"
echo "  • Joplin: http://localhost:22300"
echo "  • Tandoor: http://localhost:8081"
echo ""
echo "🔧 Next steps:"
echo "  1. Configure each service through their web interfaces"
echo "  2. Set up indexers in Prowlarr"
echo "  3. Configure download clients (qBittorrent/SABnzbd)"
echo "  4. Set up media libraries in Jellyfin"
echo "  5. Configure Jellyseerr for request management"
