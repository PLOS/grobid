# grobid packaging for debian/ubuntu

The debian branch of the repository is an orphan branch containing
only the code and configuration needed to generate a package of 
grobid inside of a tomcat7 container.

## building a package

The recommended workflow for building a package is as follows:

1. First, create a new branch off of the commit you want to release.
For example, grobid uses tags like `grobid-parent-0.4.1`. To build grobid-0.4.1, you might do something like `git checkout -b build/0.4.1 grobid-parent-0.4.1`.

1. The previous command should leave on you a new `build/0.4.1` branch, which has as its parent the `grobid-parent-0.4.1` tag. Now you can simply merge in this debian branch: `git merge debian`.

1. Once you have merged the `debian` branch, use the `build-package.sh` script to build your package. The first argument to the script is the package version, and the second argument is a build revision, e.g.:

	```
	./build-package.sh 0.4.1 plos1
	```

1. When the build successfully finishes, you should find a package in the parent folder, e.g. `../grobid-tomcat7_0.4.1-plos1_amd64.deb`

## future teamcity integration

Teamcity will be responsible for setting up the build environment and
running the `build-package.sh` script. It will then upload the built
debian package to our repos via our soon-to-be-released `wraptly` tool.