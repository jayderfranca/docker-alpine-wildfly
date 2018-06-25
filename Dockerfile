FROM openjdk:8-alpine

ENV WILDFLY_VERSION 13.0.0.Final
ENV WILDFLY_SHA1 3d63b72d9479fea0e3462264dd2250ccd96435f9
ENV JBOSS_HOME /opt/jboss/wildfly
ENV LAUNCH_JBOSS_IN_BACKGROUND true

LABEL maintainer="Jayder França <jayderfranca@gmail.com>"
LABEL source="https://github.com/jayderfranca/docker-alpine-wildfly"
LABEL version="${WILDFLY_VERSION}"

RUN mkdir /opt \
 && addgroup -g 1000 jboss \
 && adduser -u 1000 -G jboss -D -h /opt/jboss -s /sbin/nologin jboss \
 && chmod 0755 /opt/jboss \
 && cd $HOME \
 && wget https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
 && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
 && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
 && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
 && rm wildfly-$WILDFLY_VERSION.tar.gz \
 && chown -R jboss:0 ${JBOSS_HOME} \
 && chmod -R g+rw ${JBOSS_HOME}

USER jboss

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
