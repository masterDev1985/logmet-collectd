# logmet-logstash

Repository to contain a Dockerfile to build a docker image for Logmet's collectd.

Logmet releases a collectd distribution that has a built-in  plugin that goes and
sends your metrics to Logmet's servers.

It's an output plugin.

This repo containerizes that plugin and its provided collectd to allow for testing in our world.