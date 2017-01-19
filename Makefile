SHELL = /bin/bash
INSTALL_PATH=/opt/grobid
M2_REPO=$(HOME)/.m2/repository

install: FINAL_PATH = $(DESTDIR)$(INSTALL_PATH)

all:

install:
	mvn -Dmaven.test.skip=true -Dmaven.repo.local=$(M2_REPO) clean install -PgenericBuild
	rm -rf $(FINAL_PATH)
	tomcat7-instance-create -p 8090 -c 8015 $(FINAL_PATH)
	cp grobid-service/target/grobid-service-*.war $(FINAL_PATH)/webapps/grobid.war
	unzip -d /tmp grobid-home/target/grobid-home-*.zip
	cp grobid-home/config/*.properties $(FINAL_PATH)/conf
	mkdir $(FINAL_PATH)/data
	cp -R /tmp/grobid-home/language-detection /tmp/grobid-home/lexicon /tmp/grobid-home/lib $(FINAL_PATH)/data
	cp -R /tmp/grobid-home/models /tmp/grobid-home/pdf2xml $(FINAL_PATH)/data
	rm -rf /tmp/grobid-home
	mvn -Dmaven.test.skip=true -Dmaven.repo.local=$(M2_REPO) clean 

