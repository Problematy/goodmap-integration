#!/bin/bash

set -e

BACKEND_VERSION=$1
FRONTEND_VERSION=$2

BACKEND_DIR="${HOME}/backend/goodmap-${BACKEND_VERSION}"
CONFIG="${BACKEND_DIR}/tests/e2e_tests/e2e_test_config.yml"

function download_project(){
  curl -L "https://github.com/Problematy/goodmap/archive/${BACKEND_VERSION}.zip" -o "backend.zip"
  curl -L "https://github.com/Problematy/goodmap-frontend/archive/${FRONTEND_VERSION}.zip" -o "frontend.zip"
  unzip "frontend.zip" -d "frontend"
  unzip "backend.zip" -d "backend"
  rm -rf "frontend.zip backend.zip"
}

function build_frontend(){
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

function main() {
  download_project
  build_frontend
  change_config
  run_backend
}

main
