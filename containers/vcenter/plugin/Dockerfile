ARG CONTRAIL_REGISTRY
ARG CONTRAIL_CONTAINER_TAG
FROM ${CONTRAIL_REGISTRY}/contrail-base:${CONTRAIL_CONTAINER_TAG}

ARG CONTAINER_NAME
LABEL name=$CONTAINER_NAME \
      summary="VMware vCenter plugin" \
      description="VMware vCenter plugin workflows are represented as simple workflows in vRO plugin."

RUN yum install -y java-1.7.0-openjdk \
    libcontrail-java-api libcontrail-vijava \
    libcontrail-vrouter-java-api contrail-vcenter-plugin \
    yum clean all && \
    rm -rf /var/cache/yum && \
    ldconfig

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/contrail-vcenter-plugin"]

ENV NODE_TYPE=vcenter
ENV SERVICE_NAME=plugin
LABEL net.juniper.contrail.service=$SERVICE_NAME
LABEL net.juniper.contrail.container.name=$CONTAINER_NAME
