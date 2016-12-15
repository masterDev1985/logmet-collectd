FROM ubuntu
MAINTAINER benjsmi@us.ibm.com
MAINTAINER davery@us.ibm.com

RUN apt-get update ; apt-get install -y wget ; \
	wget -O - https://downloads.opvis.bluemix.net:5443/client/IBM_Logmet_repo_install.sh | bash ; \
	apt-get install -y collectd-write-mtlumberjack

COPY mt-metrics-writer.conf /etc/collectd/collectd.conf.d/

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["collectd", "-f"]
