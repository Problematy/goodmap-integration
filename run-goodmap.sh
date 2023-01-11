#!/bin/bash

WORKDIR="${HOME}"

BACKEND_DIR="${WORKDIR}/backend/goodmap"
CONFIG="${BACKEND_DIR}/tests/e2e_tests/e2e_test_config.yml"

function get_backend() {
  VERSION="$1"
  curl -L "https://github.com/Problematy/goodmap/archive/${VERSION}.zip" -o "backend.zip"
  unzip "backend.zip" -d "backend"
  mv "backend/goodmap-${VERSION}" "backend/goodmap"
  rm -rf "backend.zip"
}

function get_frontend() {
  VERSION="$1"
  curl -L "https://github.com/Problematy/goodmap-frontend/archive/${VERSION}.zip" -o "frontend.zip"
  unzip "frontend.zip" -d "frontend"
  mv "frontend/goodmap-frontend-${VERSION}" "frontend/goodmap"
  rm -rf "frontend.zip"
}

function build_frontend() {
  pushd "frontend/goodmap-frontend-${FRONTEND_VERSION}"
  npm i
  npm run serve&
  popd
}

function run_backend(){
  pushd ${BACKEND_DIR}
  poetry install
  poetry run flask --app "goodmap.goodmap:create_app(config_path='${CONFIG}')" --debug run --port 5000 --host=0.0.0.0
  popd
}

function change_config() {
  sed -i -E "s_(/static/map.js: )(.*)_\1 http://localhost:8080/map.js_" $CONFIG
  echo "USE_WWW: false" >> $CONFIG
}

function serve_custom_frontend() {
  build_frontend
  change_config
}

function main() {
  if [ -z ${BACKEND_VERSION+x} ]
  then
    get_backend "${BACKEND_VERSION}"
    if [ -z ${FRONTEND_VERSION+x} ]
    then
      serve_custom_frontend "${FRONTEND_VERSION}"
    fi
  fi
  run_backend
}

"$@"
