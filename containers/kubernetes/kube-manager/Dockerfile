ARG CONTRAIL_REGISTRY
ARG CONTRAIL_CONTAINER_TAG
FROM ${CONTRAIL_REGISTRY}/contrail-base:${CONTRAIL_CONTAINER_TAG}

ARG CONTAINER_NAME
LABEL name=$CONTAINER_NAME \
      summary="Contrail Kubernetes Manager" \
      description="Contrail Kubernetes Manager provides listening to the Kubernetes API messages and creating corresponding resources in the Contrail API database."

RUN yum install -y python-eventlet python-setuptools python-kazoo \
                   python-bitarray python-pycassa python-bitstring \
                   contrail-kube-manager python-enum34 && \
    yum clean all -y && \
    rm -rf /var/cache/yum

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/python", "/usr/bin/contrail-kube-manager", "-c", "/etc/contrail/contrail-kubernetes.conf"]

ENV NODE_TYPE=kubernetes
ENV SERVICE_NAME=kube-manager
LABEL net.juniper.contrail.pod=$NODE_TYPE
LABEL net.juniper.contrail.service=$SERVICE_NAME
LABEL net.juniper.contrail.container.name=$CONTAINER_NAME
