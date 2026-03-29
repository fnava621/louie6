#!/bin/bash
# Deploy static site to exe.dev VM
#
# Usage:
#   1. Create a VM:  ssh exe.dev  →  new --name=kodiak
#   2. Run this:     ./deploy.sh kodiak.exe.xyz
#
# Your site will be live at https://kodiak.exe.xyz

set -e

VM_HOST="${1:?Usage: ./deploy.sh <vm-hostname>}"

echo "Deploying to $VM_HOST..."

# Install nginx and set up site directory
ssh "$VM_HOST" "sudo apt-get update -qq && sudo apt-get install -y -qq nginx > /dev/null"

# Copy site files
scp -r site/* "$VM_HOST":/tmp/kodiak-site/

# Move into place and configure nginx
ssh "$VM_HOST" "
  sudo rm -rf /var/www/kodiak
  sudo mv /tmp/kodiak-site /var/www/kodiak
  sudo cp /var/www/kodiak/nginx.conf /etc/nginx/sites-available/kodiak
  sudo ln -sf /etc/nginx/sites-available/kodiak /etc/nginx/sites-enabled/kodiak
  sudo rm -f /etc/nginx/sites-enabled/default
  sudo nginx -t && sudo systemctl restart nginx
"

echo "Done! Site is live at https://$VM_HOST"
