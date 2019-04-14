#!/bin/bash

# Copyright � 2016-2019 Mozg. All rights reserved.

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -Eeuxo pipefail
set -Eeu
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
function error() {
    JOB="$0"              # job name
    LASTLINE="$1"         # line of error occurrence
    LASTERR="$2"          # error code
    echo "ERROR in ${JOB} : line ${LASTLINE} with exit code ${LASTERR}"
    exit 1
}
trap 'error ${LINENO} ${?}' ERR

#

function setVars {

  RED='\033[0;31m'
  NC='\033[0m' # No Color
  echo -e "${RED} ${FUNCNAME[0]} ${NC}"

  SOURCE_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
  echo "SOURCE_DIR: $SOURCE_DIR"
  echo "SHELL: $SHELL"
  echo "TERM: $TERM"

  # Define text styles
  BOLD=''
  NORMAL=''
  [ -z ${TERM} ] || {
    #BOLD=`tput bold` # Error Heroku, tput: No value for $TERM and no -T specified
    #NORMAL=`tput sgr0`
    BOLD=$(tput bold)
    NORMAL=$(tput sgr0)
  }

  # Reset
  RESETCOLOR='\e[0m'       # Text Reset

  # Regular Colors
  BLACK='\e[0;30m'        # Black
  RED='\e[0;31m'          # Red
  GREEN='\e[0;32m'        # Green
  YELLOW='\e[0;33m'       # Yellow
  BLUE='\e[0;34m'         # Blue
  PURPLE='\e[0;35m'       # Purple
  CYAN='\e[0;36m'         # Cyan
  WHITE='\e[0;37m'        # White

  # Background
  ONBLACK='\e[40m'       # Black
  ONRED='\e[41m'         # Red
  ONGREEN='\e[42m'       # Green
  ONYELLOW='\e[43m'      # Yellow
  ONBLUE='\e[44m'        # Blue
  ONPURPLE='\e[45m'      # Purple
  ONCYAN='\e[46m'        # Cyan
  ONWHITE='\e[47m'       # White

  # Nice defaults
  NOW_2_FILE=$(date +%Y-%m-%d_%H-%M-%S)
  DATE_EN_US=$(date '+%Y-%m-%d %H:%M:%S')
  DATE_PT_BR=$(date '+%d/%m/%Y %H:%M:%S')

}

setVars

#

function echio {
  local MESSAGE="$1"
  echo -e "${GREEN}${MESSAGE}${RESETCOLOR}"
}

function fnc_before {
  local _FUNCNAME="$1 {"
  echo -e "${ONBLUE}${_FUNCNAME}${RESETCOLOR}"
}

function fnc_after {
  echo -e "${ONBLUE}}${RESETCOLOR}"
}

# methods

function mysql_show_tables {

  fnc_before ${FUNCNAME[0]}

  MYSQL_SHOW_TABLES=`mysql -h "${RDS_HOSTNAME}" -P "${RDS_PORT}" -u "${RDS_USERNAME}" -p"${RDS_PASSWORD}" "${RDS_DB_NAME}" -N -e "SHOW TABLES"`

  echio "-"

  #echo $MYSQL_SHOW_TABLES

  fnc_after

}

function mysql_select_admin_user {

  fnc_before ${FUNCNAME[0]}

  MYSQL_SELECT_ADMIN_USER=`mysql -h "${RDS_HOSTNAME}" -P "${RDS_PORT}" -u "${RDS_USERNAME}" -p"${RDS_PASSWORD}" "${RDS_DB_NAME}" -N -e "SELECT * FROM admin_user"`

  echio "-"

  #echo $MYSQL_SELECT_ADMIN_USER

  fnc_after

}

function download_n98_magerun2 {

  fnc_before ${FUNCNAME[0]}

  pwd

  [[ "$(command -v n98-magerun2)" ]] || { echo "n98-magerun2 is not installed" 1>&2 ; }
  [[ -f "./n98-magerun2.phar" ]] || { echo "n98-magerun2 local installed" 1>&2 ; }

  if [ ! -f "./n98-magerun2.phar" ]; then # -z String, True if string is empty.
    echio "n98-magerun2"
    wget https://files.magerun.net/n98-magerun2.phar
    chmod +x ./n98-magerun2.phar
  fi

  fnc_after

}

function run_n98_magerun2 {

  fnc_before ${FUNCNAME[0]}

  echio "check n98-magerun2"

  pwd

  #php bin/magento --version
  #../n98-magerun2.phar --version

  ./n98-magerun2.phar --root-dir=magento sys:check

  ../n98-magerun2.phar local-config:generate "$RDS_HOSTNAME:$RDS_PORT" "$RDS_USERNAME" "$RDS_PASSWORD" "$RDS_DB_NAME" "files" "admin" "secret" -vvv

  #./n98-magerun2.phar sys:check
  # PHP Fatal error:  Uncaught Error: Cannot instantiate interface Magento\Store\Api\StoreRepositoryInterface in /var/app/current/magento/vendor/magento/framework/ObjectManager/Factory/Dynamic/Developer.php:50

  fnc_after

}

function create_env_file {

  fnc_before ${FUNCNAME[0]}

  cp $SOURCE_DIR/env.php $SOURCE_DIR/magento/app/etc/

  #php -d memory_limit=-1 bin/magento setup:config:set --backend-frontname "admin" --db-host "${RDS_HOSTNAME}:${RDS_PORT}" --db-name "${RDS_DB_NAME}" --db-user "${RDS_USERNAME}" --db-engine "innodb" --db-password "${RDS_PASSWORD}" --db-prefix "" --db-model "mysql4" --session-save "files" --no-interaction

  MAGENTO_DB_NAME="${RDS_DB_NAME}"
  MAGENTO_DB_HOST="${RDS_HOSTNAME}:${RDS_PORT}"
  MAGENTO_DB_USER="${RDS_USERNAME}"
  MAGENTO_DB_PASSWORD="${RDS_PASSWORD}"
  MAGENTO_SESSION_HOST=""
  MAGENTO_SESSION_PORT=""
  MAGENTO_SESSION_DATABASE=""
  MAGENTO_CACHE_HOST=""
  MAGENTO_CACHE_PORT=""
  MAGENTO_CACHE_DATABASE=""
  MAGENTO_WEBCACHE_HOST=""
  MAGENTO_ADMIN_URL="admin"
  MAGENTO_CRYPT="f60fa446970609cc91d0a65a5e885b8e"

  sed -i "s/{{MAGENTO_DB_NAME}}/${MAGENTO_DB_NAME}/g" $SOURCE_DIR/magento/app/etc/env.php
  sed -i "s/{{MAGENTO_DB_HOST}}/${MAGENTO_DB_HOST}/g" $SOURCE_DIR/magento/app/etc/env.php
  sed -i "s/{{MAGENTO_DB_USER}}/${MAGENTO_DB_USER}/g" $SOURCE_DIR/magento/app/etc/env.php
  sed -i "s/{{MAGENTO_DB_PASSWORD}}/${MAGENTO_DB_PASSWORD}/g" $SOURCE_DIR/magento/app/etc/env.php

  sed -i "s/{{MAGENTO_SESSION_HOST}}/${MAGENTO_SESSION_HOST}/g" $SOURCE_DIR/magento/app/etc/env.php
  sed -i "s/{{MAGENTO_SESSION_PORT}}/${MAGENTO_SESSION_PORT}/g" $SOURCE_DIR/magento/app/etc/env.php
  sed -i "s/{{MAGENTO_SESSION_DATABASE}}/${MAGENTO_SESSION_DATABASE}/g" $SOURCE_DIR/magento/app/etc/env.php

  sed -i "s/{{MAGENTO_CACHE_HOST}}/${MAGENTO_CACHE_HOST}/g" $SOURCE_DIR/magento/app/etc/env.php
  sed -i "s/{{MAGENTO_CACHE_PORT}}/${MAGENTO_CACHE_PORT}/g" $SOURCE_DIR/magento/app/etc/env.php
  sed -i "s/{{MAGENTO_CACHE_DATABASE}}/${MAGENTO_CACHE_DATABASE}/g" $SOURCE_DIR/magento/app/etc/env.php

  sed -i "s/{{MAGENTO_WEBCACHE_HOST}}/${MAGENTO_WEBCACHE_HOST}/g" $SOURCE_DIR/magento/app/etc/env.php

  sed -i "s/{{MAGENTO_ADMIN_URL}}/${MAGENTO_ADMIN_URL:-admin}/g" $SOURCE_DIR/magento/app/etc/env.php
  sed -i "s/{{MAGENTO_CRYPT}}/${MAGENTO_CRYPT}/g" $SOURCE_DIR/magento/app/etc/env.php

  fnc_after

}

function release_host {

  fnc_before ${FUNCNAME[0]}

  echio "download_n98_magerun2"

  download_n98_magerun2

  echio "path"

  pwd
  cd $SOURCE_DIR/magento
  pwd

  echio "ls -lah app/etc"

  ls -lah app/etc

  echio "whoami - print effective userid"

  whoami

  echio "env"

  env

  echio "CREATE: app/etc/config.php"

  php -d memory_limit=-1 bin/magento module:enable --all --clear-static-content

  echio "CREATE: app/etc/env.php"

  create_env_file

  echio "pwd && ls -lah app/etc"

  pwd && ls -lah app/etc

  permission_private

  echio "pwd && ls -lah app/etc"

  pwd && ls -lah app/etc

  after_install

  fnc_after

}

function after_install {

  fnc_before ${FUNCNAME[0]}

  is_folder_magento

  echio "pwd"
  pwd

  echio "mysql"

  mysql -h "${RDS_HOSTNAME}" -P "${RDS_PORT}" -u "${RDS_USERNAME}" -p"${RDS_PASSWORD}" -e 'SHOW databases;'

 #echio "-"
  #php -d memory_limit=-1 bin/magento

    if [ $(whoami) = "ec2-user" ]; then

    echio "setup:db:status"
    php -d memory_limit=-1 bin/magento setup:db:status

    echio "cache:disable"
    php -d memory_limit=-1 bin/magento cache:disable

    echio "cache:clean"
    php -d memory_limit=-1 bin/magento cache:clean

    echio "cache:flush"
    php -d memory_limit=-1 bin/magento cache:flush

    echio "cache:status"
    php -d memory_limit=-1 bin/magento cache:status

    echio "indexer:reindex"
    php -d memory_limit=-1 bin/magento indexer:reindex

    echio "indexer:status"
    php -d memory_limit=-1 bin/magento indexer:status

    echio "maintenance:status"
    php -d memory_limit=-1 bin/magento maintenance:status

    echio "module:status"
    php -d memory_limit=-1 bin/magento module:status

    echio "deploy:mode:show"
    php -d memory_limit=-1 bin/magento deploy:mode:show

    echio "deploy:mode:set"

    if [ -f ".env" ] ; then # if file exits, only local
      MAGE_MODE="developer"
    else
      MAGE_MODE="production"
    fi

    php -d memory_limit=-1 bin/magento deploy:mode:set $MAGE_MODE

  fi

  echio "setup:upgrade"
  php bin/magento setup:upgrade

  echio "WARNING: Please run the 'setup:di:compile' command to generate classes."

  php bin/magento setup:di:compile

  php bin/magento setup:static-content:deploy pt_BR

  fnc_after

}

function is_folder_magento {

  fnc_before ${FUNCNAME[0]}

  if [ ! -d "phpserver" ] ; then # if directory not exits
    echio "phpserver not exists"
    exit
  fi

  fnc_after

}

function magento_install {

  fnc_before ${FUNCNAME[0]}

  is_folder_magento

  echio "install.php"

php bin/magento setup:install \
--base-url="$MAGE_URL" \
--db-host="${RDS_HOSTNAME}:${RDS_PORT}" \
--db-name="${RDS_DB_NAME}" \
--db-user="${RDS_USERNAME}" \
--db-password="${RDS_PASSWORD}" \
--backend-frontname="admin" \
--admin-firstname="Marcio" \
--admin-lastname="Amorim" \
--admin-email="mailer@mozg.com.br" \
--admin-user="admin" \
--admin-password="123456a" \
--language="pt_BR" \
--currency="BRL" \
--timezone="America/Sao_Paulo" \
--use-rewrites="1"

echio "magento/index.php"

php index.php

echio "-"

after_install

echio "https://magenticians.com/why-magento-2-is-slow/"

php bin/magento config:set catalog/frontend/flat_catalog_product 1
# php bin/magento config:set dev/js/enable_js_bundling 1 # Production
php bin/magento config:set dev/js/merge_files 1
php bin/magento config:set dev/js/minify_files 1
php bin/magento config:set dev/css/merge_css_files 1
php bin/magento config:set dev/css/minify_files 1
php bin/magento config:set dev/static/sign 0

fnc_after

}

function release {

  fnc_before ${FUNCNAME[0]}


  fnc_after

}

function post_update_cmd { # post-update-cmd: occurs after the update command has been executed, or after the install command has been executed without a lock file present.
# Na heroku o Mysql ainda n�o foi instalado nesse ponto

fnc_before ${FUNCNAME[0]}

echio "mkdir"

[[ ! -f "backdoor" ]] || { mkdir backdoor ; }

echio "cp"

if [ -d magento/vendor/prasathmani/tinyfilemanager ]; then
  echio "prasathmani/tinyfilemanager"
  cp -fr magento/vendor/prasathmani/tinyfilemanager backdoor
fi

if [ -d magento/vendor/maycowa/commando ]; then
  echio "maycowa/commando"
  cp -fr magento/vendor/maycowa/commando backdoor
fi

profile

fnc_after

}

function post_install_cmd { # post-install-cmd: occurs after the install command has been executed with a lock file present.

fnc_before ${FUNCNAME[0]}

post_update_cmd

fnc_after

}

function postdeploy { # postdeploy command. Use this to run any one-time setup tasks that make the app, and any databases, ready and useful for testing.

fnc_before ${FUNCNAME[0]}

post_update_cmd # post-update-cmd: occurs after the update command has been executed, or after the install command has been executed without a lock file present.

fnc_after

}

function profile { # Heroku, During startup, the container starts a bash shell that runs any code in $HOME/.profile before executing the dyno�s command. You can put bash code in this file to manipulate the initial environment, at runtime, for all dyno types in your app.

  fnc_before ${FUNCNAME[0]}

  #echio "Na Heroku ao executar o profile n�o funciona o cache:disable" "$ONRED"
  #exit

  echio "path"

  pwd
  cd $SOURCE_DIR/magento
  pwd

  permission_private

  echio "pwd && ls -lah app/etc"

  pwd && ls -lah app/etc

  echio "check mysql"

  if type mysql >/dev/null 2>&1; then

    echio "mysql installed"

    if [ -f ".env" ] ; then # if file exits, only local
      if [ ! -f "magento/app/etc/env.php" ] ; then # if file not exits
      magento_install
      fi
    fi

  else
    echio "mysql not installed" "$ONRED"
  fi

  echio "-"

  if [ ! -f ".env" ] ; then # if file not exits, only heroku ...
    if [ ! -f "magento/app/etc/env.php" ] ; then # if file not exits
      release_host
    fi
  fi

  fnc_after

}

function permission_private {

  fnc_before ${FUNCNAME[0]}

  is_folder_magento

  echio "env"

  #env

  echio "OWNER & GROUP"

  OWNER=$(whoami)

  if [[ "$OWNER" != "marcio" ]]; then
    OWNER='ec2-user'
    #OWNER='webapp'
  fi

  echio "OWNER: $OWNER" "$ONCYAN"

  GROUP=`ps aux | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1`

  echio "GROUP: $GROUP" "$ONCYAN"

  echio 'https://devdocs.magento.com/guides/v2.3/config-guide/prod/prod_file-sys-perms.html'

  echio 'Production file system ownership for private hosting (two users) '

  echio 'Make code files and directories read-only'

  php bin/magento deploy:mode:set production

  find app/code lib pub/static app/etc generated/code generated/metadata var/view_preprocessed \( -type d -or -type f \) -exec chmod g-w {} + && chmod o-rwx app/etc/env.php

  echio 'Make code files and directories writable:'

  find app/code lib var generated vendor pub/static pub/media app/etc \( -type d -or -type f \) -exec chmod g+w {} + && chmod o+rwx app/etc/env.php

  fnc_after

}

function test {
  fnc_before ${FUNCNAME[0]}
  echio "SUCCESS"
  fnc_after
}

#

echio "env RDS_"
env | grep ^RDS_ || true

echio ".env loading in the shell"

function dotenv {
  set -a
  [ -f "$1" ] && . "$1"
  set +a
}

dotenv ".env"

echio "env RDS_"
env | grep ^RDS_ || true

#

METHOD=${1}

if [ ! -z $METHOD ]; then # -z String, True if string is empty.
  $METHOD
fi
