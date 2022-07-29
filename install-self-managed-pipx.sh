#!/usr/bin/env bash

echo Checking for existing pipx
which pipx > /dev/null
if [ $? -eq 0 ]; then
  echo pipx is already installed >&2
  return 1 2> /dev/null || exit 1
fi

PYTHON_BIN=${PYTHON_BIN:-python3}

echo
echo Checking python version

${PYTHON_BIN} -c '
import sys
if sys.version_info[:2] < (3, 6):
  sys.exit(1)
'
if [ $? -ne 0 ]; then
  echo Requires python version 3.6 or greater >&2
  return 1 2> /dev/null || exit 1
fi

echo
echo Creating installation directory

INSTALL_DIR=`mktemp -d -t pipx-self-managed-install-`
echo Installation directory: $INSTALL_DIR

mkdir -p ${INSTALL_DIR}
if [ $? -ne 0 ]; then
  return 1 2> /dev/null || exit 1
fi

clean_install_dir() {
  echo
  echo Removing installing directory
  rm -rf $INSTALL_DIR
}

echo
echo Create installation virtual environment

$PYTHON_BIN -m venv ${INSTALL_DIR}
if [ $? -ne 0 ]; then
  clean_install_dir
  return 1 2> /dev/null || exit 1
fi

echo
echo Update pip

$INSTALL_DIR/bin/pip install --upgrade pip
if [ $? -ne 0 ]; then
  clean_install_dir
  return 1 2> /dev/null || exit 1
fi

echo
echo Installing bootstrap pipx

$INSTALL_DIR/bin/pip install pipx
if [ $? -ne 0 ]; then
  clean_install_dir
  return 1 2> /dev/null || exit 1
fi

echo
echo Installing self managed pipx

$INSTALL_DIR/bin/pipx install --python $PYTHON_BIN pipx
if [ $? -ne 0 ]; then
  clean_install_dir
  return 1 2> /dev/null || exit 1
fi

clean_install_dir
