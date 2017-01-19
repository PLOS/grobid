#!/bin/bash

export DEBFULLNAME="PLOS Grobid Packagers"
export DEBEMAIL="it-ops@plos.org"

if ! which dch; then
    echo " * please install the devscripts package"
    exit 1
fi

if [ -z "$1" ]; then
    echo " * you must provide a version number as the first argument"
    exit 1
fi

if [ -f "debian/changelog" ]; then
    rm debian/changelog
fi

dch --create --distribution stable -v "$1" --package grobid "this file is not maintained"
dpkg-buildpackage -b -us -uc

git checkout grobid-trainer/resources/dataset/entities/chemistry/corpus/chemistry-types.xml.orig
git checkout debian/changelog
