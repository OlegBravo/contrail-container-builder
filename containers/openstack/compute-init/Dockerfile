ARG CONTRAIL_REGISTRY
ARG CONTRAIL_CONTAINER_TAG
FROM ${CONTRAIL_REGISTRY}/contrail-base:${CONTRAIL_CONTAINER_TAG}

ARG CONTAINER_NAME
LABEL name=$CONTAINER_NAME \
      summary="Init container for OpenStack Compute" \
      description="Sidecar container with libraries for nova-compute."

RUN yum install -y contrail-vrouter-agent contrail-nova-vif && \
    mkdir -p /opt/contrail/bin && \
    cp /usr/bin/vrouter-port-control /opt/contrail/bin && \
    yum remove -y contrail-vrouter-agent && \
    yum autoremove -y && yum clean all -y && \
    rm -rf /var/cache/yum

COPY *.sh /

ENTRYPOINT ["/entrypoint.sh"]

LABEL net.juniper.contrail.container.name=$CONTAINER_NAME
