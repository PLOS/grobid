#!/bin/bash

version=${1}
deb_revision=${2}
export DEBFULLNAME="PLOS Grobid Packagers"
export DEBEMAIL="it-ops@plos.org"
export QUILT_PATCHES="debian/patches"

if ! which dch; then
    echo " * please install the devscripts package"
    exit 1
fi

if [[ ! ${version} ]]; then
    echo " * you must provide a version number as the first argument"
    exit 1
fi

if [[ ! ${deb_revision} ]]; then
    echo " * you must provide a package revision, e.g. plos1, as the second argument"
    exit 1
fi

quilt push -a

rm -f debian/changelog
dch --create --distribution stable -v "${version}-${deb_revision}" --package grobid-tomcat7 "this file is not maintained"

dpkg-buildpackage -b -us -uc

git checkout grobid-trainer/resources/dataset/entities/chemistry/corpus/chemistry-types.xml.orig
git checkout debian/changelog
