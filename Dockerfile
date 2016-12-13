FROM openjdk:8
MAINTAINER benjsmi@us.ibm.com

COPY ./logstash-mtlumberjack.tgz /opt/

RUN cd /opt ; tar xvzf logstash-mtlumberjack.tgz ; mkdir -p /opt/logstash/conf.d

COPY ./logstash.conf /opt/logstash/conf.d/

ENV PATH /opt/logstash/bin:$PATH

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["-f", "/opt/logstash/conf.d"]