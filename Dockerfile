FROM ubuntu
MAINTAINER benjsmi@us.ibm.com

RUN apt-get update && apt-get install -y wget
RUN wget -O - https://downloads.opvis.bluemix.net:5443/client/IBM_Logmet_repo_install.sh | bash
RUN apt-get install -y collectd-write-mtlumberjack

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["collectd", "-f"]
