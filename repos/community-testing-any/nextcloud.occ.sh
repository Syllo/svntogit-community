#!/usr/bin/env bash

readonly default_config="/etc/php/php.ini"
readonly default_php_command="/usr/bin/php"
readonly default_user="nextcloud"

config=""
php_command=""
user=""

check_sudo() {
  if ! command -v sudo > /dev/null; then
    printf "The sudo command is not available.\n"
    exit 1
  fi
}

check_sudo

# allow overriding the php.ini
if [[ -n "${PHP_CONFIG}" ]] && [[ -f "${PHP_CONFIG}" ]]; then
  config="${PHP_CONFIG}"
else
  config="${default_config}"
fi

# allow overriding the php executable
if [[ -n "${PHP}" ]] && command -v "${PHP}" > /dev/null; then
  php_command="${PHP}"
else
  php_command="${default_php_command}"
fi

# allow overriding the user to run as
if [[ -n "${USER}" ]]; then
  user="${USER}"
else
  user="${default_user}"
fi

sudo -u "${user}" "$php_command" -c "${config}" /usr/share/webapps/nextcloud/occ "$@"
