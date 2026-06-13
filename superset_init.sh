#!/bin/bash
set -e

# Check if Superset is already initialized
if [ ! -f /app/superset_home/.initialized ]; then
    echo "=================================================="
    echo "Initializing Superset for the first time..."
    echo "=================================================="
    
    # Run migrations
    superset db upgrade
    
    # Create admin user
    superset fab create-admin \
        --username admin \
        --firstname Admin \
        --lastname User \
        --email admin@atendas.com.br \
        --password admin
        
    # Initialize roles and permissions
    superset init
    
    # Create marker file
    touch /app/superset_home/.initialized
    echo "=================================================="
    echo "Initialization completed successfully!"
    echo "=================================================="
else
    echo "=================================================="
    echo "Superset already initialized. Skipping setup..."
    echo "=================================================="
fi

echo "Starting Superset..."
exec /usr/bin/run-server.sh
