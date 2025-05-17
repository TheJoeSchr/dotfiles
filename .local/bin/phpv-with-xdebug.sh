#!/bin/env bash
set -eo pipefail
set -x

# Usage check
if [ -z "$1" ]; then
  echo "Usage: ./$0 <version> [--xdebug|--no-xdebug|--status|--list]"
  exit 1
fi

VERSION=$1
ACTION=${2:---xdebug}

# Switching PHP version
echo "Switching to PHP $VERSION..."
# Try to switch PHP version using phpv
if ! phpv "$VERSION" >/dev/null 2>&1; then
  echo "[!] phpv failed to switch to PHP $VERSION — trying phpv -i to install..."
  phpv -i "$VERSION"
fi
phpv "$VERSION"

# Stop active php-fpm@*.service instances
for svc in $(systemctl list-units --type=service | grep 'php.*-fpm' | awk '{print $1}'); do
  echo "Stopping $svc"
  sudo systemctl stop "$svc"
  sudo systemctl disable "$svc"
done

FPM_SERVICE="php$VERSION-fpm"
# Start the desired PHP-FPM service
echo "Starting $FPM_SERVICE"
sudo systemctl enable --now "$FPM_SERVICE"

PHP_BIN="/usr/bin/php$VERSION"
CONF_DIR="/etc/php/$VERSION/conf.d"
XDEBUG_INI="$CONF_DIR/20-xdebug.ini"
PHP_EXTENSION_DIR=$($PHP_BIN -i | grep '^extension_dir' | awk '{print $3}')
XDEBUG_SO="$PHP_EXTENSION_DIR/xdebug.so"
# Handle Xdebug enable/disable
if [ "$ACTION" == "--xdebug" ]; then
  echo "- PHP binary: $PHP_BIN"
  echo "- Xdebug INI: $XDEBUG_INI"
  echo "- xdebug.so: $XDEBUG_SO"

  if [ ! -x "$PHP_BIN" ]; then
    echo "  [!] PHP $VERSION not installed."
    exit 1
  fi

  echo -n "- Active PHP version details: "
  $PHP_BIN -v | head -n 1

  if [ -f "$XDEBUG_INI" ]; then
    echo "  [✓] Xdebug config found"
    grep xdebug "$XDEBUG_INI" || echo "    (No detailed config found)"
  else
    echo "  [ ] Xdebug config NOT found"
  fi

  if [ -f "$XDEBUG_SO" ]; then
    echo "  [✓] xdebug.so present"
  else
    echo "  [ ] xdebug.so missing"
  fi

  echo "Enabling Xdebug..."
  # Check if xdebug.so exists
  if [ ! -f "$XDEBUG_SO" ]; then
    echo "xdebug.so not found for PHP $VERSION, installing via AUR..."
    pikaur -S php$VERSION-xdebug --noconfirm
    if [ ! -f "$XDEBUG_SO" ]; then
      pikaur -S php$VERSION-pecl --noconfirm
      echo "xdebug.so not found for PHP $VERSION, installing via pecl..."
      sudo php$VERSION -d detect_unicode=0 "$(which pecl)" install xdebug
      end
    fi

    # Xdebug configuration
    read -r -d '' XDEBUG_CONFIG <<EOF
zend_extension=$XDEBUG_SO
xdebug.mode=develop,debug,coverage
; xdebug.start_with_request=yes
xdebug.idekey="VSCODE"
xdebug.discover_client_host=true
EOF

    echo "$XDEBUG_CONFIG" | sudo tee "$XDEBUG_INI" >/dev/null
    echo "Xdebug enabled."

  elif [ "$ACTION" == "--no-xdebug" ]; then
    echo "Disabling Xdebug..."
    sudo rm -f "$XDEBUG_INI"
    echo "Xdebug disabled."
  else
    echo "No Xdebug change requested."
  fi

  # Restart Valet
  valet restart

  echo "PHP $VERSION active. Xdebug: ${ACTION:-unchanged}"
  php -v
fi
