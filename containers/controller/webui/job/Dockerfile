ARG CONTRAIL_REGISTRY
ARG CONTRAIL_CONTAINER_TAG
FROM ${CONTRAIL_REGISTRY}/contrail-controller-webui-base:${CONTRAIL_CONTAINER_TAG}

ARG CONTAINER_NAME
LABEL name=$CONTAINER_NAME \
      summary="Contrail WEB UI Job" \
      description="Contrail WEB UI Job middleware handles jobs from the WebUI service and contacts other Contrail services to execute them."

ENTRYPOINT ["/entrypoint.sh"]
WORKDIR /usr/src/contrail/contrail-web-core
CMD ["/usr/bin/node","jobServerStart.js"]

ENV SERVICE_NAME=job
LABEL net.juniper.contrail.service=$SERVICE_NAME
LABEL net.juniper.contrail.container.name=$CONTAINER_NAME
