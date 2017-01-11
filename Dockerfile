FROM anapsix/alpine-java:jre7
ENV MAJOR_VER 3.8
ENV MINOR_VER 3.8.12
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*
RUN adduser -D symmetricds
RUN curl -fSL http://downloads.sourceforge.net/project/symmetricds/symmetricds/symmetricds-${MAJOR_VER}/symmetric-server-${MINOR_VER}.zip -o symmetric-server-${MINOR_VER}.zip
#ADD symmetric-server-${MINOR_VER}.zip symmetric-server-${MINOR_VER}.zip
RUN unzip -q symmetric-server-${MINOR_VER}.zip -d /opt/
RUN mv /opt/symmetric-server-${MINOR_VER} /opt/symmetric
RUN chown -R symmetricds /opt/symmetric
RUN chmod -R 777 /opt/symmetric
RUN rm symmetric-server-${MINOR_VER}.zip
#RUN cd /opt/symmetric/patches/
#RUN curl -fSL https://jdbc.postgresql.org/download/postgresql-9.4.1212.jre7.jar -o postgresql-9.4.1212.jre7.jar

VOLUME /opt/symmetric/logs
VOLUME /opt/symmetric/tmp
VOLUME /opt/symmetric/engines

USER symmetricds

ENTRYPOINT ["/opt/symmetric/bin/sym"]

EXPOSE 31415
EXPOSE 31416
