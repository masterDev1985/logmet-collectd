FROM ubuntu
MAINTAINER benjsmi@us.ibm.com

RUN apt-get update ; apt-get install -y wget ; \ 
	wget -O - https://downloads.opvis.bluemix.net:5443/client/IBM_Logmet_repo_install.sh | bash ; \
	apt-get install -y collectd-write-mtlumberjack

ENV PATH /opt/logstash/bin:$PATH

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["-f", "/opt/logstash/conf.d"]