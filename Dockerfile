FROM s390x/ibmjava:8-sdk
MAINTAINER benjsmi@us.ibm.com

RUN wget -q https://artifacts.elastic.co/downloads/logstash/logstash-5.0.2.tar.gz -O /tmp/logstash.tar.gz ; \
	mkdir -p /usr/share/logstash ; \
	tar -C /usr/share/logstash --strip-components=1 -xzf /tmp/logstash.tar.gz ; \
	rm /tmp/logstash.tar.gz
	
RUN wget -q http://archive.apache.org/dist/ant/binaries/apache-ant-1.9.4-bin.tar.gz -O /tmp/ant.tar.gz ; \
	mkdir -p /usr/share/ant ; \
	tar -C /usr/share/ant --strip-components=1 -xzf /tmp/ant.tar.gz ; \
	rm /tmp/ant.tar.gz
	
RUN apt-get update ; \
	apt-get install -y unzip gcc make ; \
	cd /tmp ; \
	wget https://github.com/jnr/jffi/archive/master.zip ; \
	unzip master.zip ; \
	cd jffi-master ; \
	/usr/share/ant/bin/ant
