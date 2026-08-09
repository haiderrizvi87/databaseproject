#!/usr/bin/env bash
# Runs once when the Codespace is first created.
# 1. Installs the mysql command-line client inside the dev container.
# 2. Waits for the MySQL server (the "db" service) to accept connections.
# 3. Loads pub.sql (the pubs database) and sports_joins.sql
#    (the sports_joins database) so both are ready before Module 0 starts.

set -e

echo "Installing MySQL client..."
sudo apt-get update -qq
sudo apt-get install -y -qq mysql-client > /dev/null

echo "Waiting for MySQL server to be ready..."
until mysql -h 127.0.0.1 -P 3306 -uroot -psqlcourse -e "SELECT 1" > /dev/null 2>&1; do
  sleep 2
  echo "  still waiting..."
done

echo "Loading pub.sql (creates and fills the 'pubs' database)..."
mysql -h 127.0.0.1 -P 3306 -uroot -psqlcourse < data/pub.sql

echo "Loading sports_joins.sql (creates and fills 'sports_joins')..."
mysql -h 127.0.0.1 -P 3306 -uroot -psqlcourse < data/sports_joins.sql

echo ""
echo "Setup complete. Connect with:"
echo "  mysql -h 127.0.0.1 -P 3306 -uroot -psqlcourse"
echo ""
echo "Then run: USE pubs;   or   USE sports_joins;"
