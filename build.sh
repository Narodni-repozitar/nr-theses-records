#!/bin/bash
#
# Copyright (c) 2022 CESNET
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT


pip install -U pip setuptools wheel

set -e

cp -r models nr-theses-records-model-builder/nr_theses_records_model_builder/

test -d dist && rm -rf dist

mkdir dist

export VERSION="$(git describe --tags --abbrev=0)"

if [ "a$VERSION" = "a" ] ; then
    echo "No version yet, setting it to 0.0.1"
    VERSION="0.0.1"
fi

export VERSION="__version__=\"$VERSION\""
echo "version will be: $VERSION"

# create library distribution
(
  cd nr-theses-records
  echo "$VERSION" > nr_theses_records/version.py
  test -d dist && rm -rf dist
  cp ../README.md .
  cat setup.cfg
  python setup.py sdist bdist_wheel
  cp dist/*.tar.gz  ../dist/
  cp dist/*.whl  ../dist/
)

# create model builder extension package
(
  cd nr-theses-records-model-builder
  echo "$VERSION" > nr_theses_records_model_builder/version.py
  test -d dist && rm -rf dist
  cp ../README.md .
  cat setup.cfg
  python setup.py sdist bdist_wheel
  cp dist/*.tar.gz  ../dist/
  cp dist/*.whl  ../dist/
)

# just list created stuff
ls -la dist

for i in dist/*.tar.gz; do
  echo
  echo Listing $i
  tar -tf $i
done
