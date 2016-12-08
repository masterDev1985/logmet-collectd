FROM s390x/ibmjava:8-sdk
MAINTAINER benjsmi@us.ibm.com

# install plugin dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
		apt-transport-https \
		libzmq5 \
	&& rm -rf /var/lib/apt/lists/*

# the "ffi-rzmq-core" gem is very picky about where it looks for libzmq.so
RUN mkdir -p /usr/local/lib \
	&& ln -s /usr/lib/*/libzmq.so.3 /usr/local/lib/libzmq.so

# https://www.elastic.co/guide/en/logstash/5.0/installing-logstash.html#_apt
# https://artifacts.elastic.co/GPG-KEY-elasticsearch
# RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4
RUN rm /etc/apt/trusted.gpg && wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -

RUN echo 'deb https://artifacts.elastic.co/packages/5.x/apt stable main' > /etc/apt/sources.list.d/logstash.list

ENV LOGSTASH_VERSION 5.0.2
ENV LOGSTASH_DEB_VERSION 5.0.2

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends "logstash=$LOGSTASH_DEB_VERSION" \
	&& rm -rf /var/lib/apt/lists/*

ENV PATH %%LOGSTASH_PATH%%:$PATH

# necessary for 5.0+ (overriden via "--path.settings", ignored by < 5.0)
ENV LS_SETTINGS_DIR /etc/logstash
# comment out some troublesome configuration parameters
#   path.config: No config files found: /etc/logstash/conf.d/*
RUN set -ex; \
	if [ -f "$LS_SETTINGS_DIR/logstash.yml" ]; then \
		sed -ri 's!^path\.config:!#&!g' "$LS_SETTINGS_DIR/logstash.yml"; \
	fi; \
# if the "log4j2.properties" file exists (logstash 5.x), let's empty it out so we get the default: "logging only errors to the console"
	if [ -f "$LS_SETTINGS_DIR/log4j2.properties" ]; then \
		cp "$LS_SETTINGS_DIR/log4j2.properties" "$LS_SETTINGS_DIR/log4j2.properties.dist"; \
		truncate --size=0 "$LS_SETTINGS_DIR/log4j2.properties"; \
	fi

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["-e", ""]