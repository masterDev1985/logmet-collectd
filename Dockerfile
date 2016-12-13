FROM openjdk:8
MAINTAINER benjsmi@us.ibm.com

COPY ./logstash-mtlumberjack.tgz /opt/

RUN cd /opt ; tar xvzf logstash-mtlumberjack.tgz

ENV PATH /opt/logstash/bin:$PATH

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["-e", ""]