FROM cassandra:3.11.3

ARG CONTAINER_NAME
ARG CONTRAIL_CONTAINER_TAG
LABEL vendor="Juniper" \
      version=$CONTRAIL_CONTAINER_TAG \
      release="5.1.0" \
      name=$CONTAINER_NAME \
      summary="Contrail Cassandra DB" \
      description="Configuration database for Contrail Controller."

# Add required license as text file in Liceses directory
RUN mkdir /licenses
COPY __licensing.txt /licenses/licensing.txt

COPY *.sh /
RUN /bin/bash -c 'for item in `ls /__*` ; do mv $item /${item:3} ; done'

ENTRYPOINT ["/contrail-entrypoint.sh"]
CMD ["cassandra", "-f"]

ENV SERVICE_NAME=cassandra
LABEL net.juniper.contrail.service=$SERVICE_NAME
LABEL net.juniper.contrail.container.name=$CONTAINER_NAME
