#!/bin/bash

WORKDIR="${HOME}"

BACKEND_DIR="${WORKDIR}/backend/goodmap"
CONFIG="${BACKEND_DIR}/tests/e2e_tests/e2e_test_config.yml"

function get_backend() {
  rm -rf "backend"
  VERSION="$1"
  curl -L "https://github.com/Problematy/goodmap/archive/${VERSION}.zip" -o "backend.zip"
  unzip "backend.zip" -d "backend"
  mv "backend/goodmap-${VERSION}" "backend/goodmap"
  rm -rf "backend.zip"
}

function get_frontend() {
  rm -rf "frontend"
  VERSION="$1"
  curl -L "https://github.com/Problematy/goodmap-frontend/archive/${VERSION}.zip" -o "frontend.zip"
  unzip "frontend.zip" -d "frontend"
  mv "frontend/goodmap-frontend-${VERSION}" "frontend/goodmap"
  rm -rf "frontend.zip"
}

function build_frontend() {
  pushd "frontend/goodmap"
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
  if [ -n "${BACKEND_VERSION}" ]
  then
    get_backend "${BACKEND_VERSION}"
  fi

  if [ -n "${FRONTEND_VERSION}" ]
  then
    get_frontend "${FRONTEND_VERSION}"
    serve_custom_frontend
  fi

  run_backend
}

"$@"
