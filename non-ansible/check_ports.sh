#!/bin/env sh

# Current timestamp in format: 2020-12-24-115959
TIMESTAMP=`date '+%F-%H%M%S'`

# Output directory:
# data and error files will be saved to this folder
OUTPUT_DIR=/tmp/check_ports

make_filename () {
  echo $OUTPUT_DIR/$TIMESTAMP-$1.csv | tr '[:upper:]' '[:lower:]'
}

check_ports_state () {
  local data_filename=$(make_filename $1)
  local error_filename=$(make_filename 'err')
  netstat -tupan | grep $1 1>>$data_filename 2>>$error_filename
}

ensure_output_dir () {
  if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p $OUTPUT_DIR

    if [ "$?" != "0" ]; then
      echo "Can't create output dir: $OUTPUT_DIR"
      exit 1
    fi
  fi
}

ensure_output_dir

check_ports_state 'LISTEN'
check_ports_state 'ESTABLISH'

# vim: set sw=2 et ts=2: 
