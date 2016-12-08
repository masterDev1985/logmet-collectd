FROM s390x/ibmjava:8-sdk
MAINTAINER benjsmi@us.ibm.com

RUN wget -q https://artifacts.elastic.co/downloads/logstash/logstash-5.0.2.tar.gz -O /tmp/logstash.tar.gz ; \
	mkdir -p /usr/share/logstash ; \
	tar -C /usr/share/logstash --strip-components=1 -xzqf /tmp/logstash.tar.gz ; rm /tmp/logstash.tar.gz