# This is the general base for all: non-contrail specfic like external and for contrail specific

ARG LINUX_DISTR=centos
ARG LINUX_DISTR_VER=7.4.1708
FROM $LINUX_DISTR:$LINUX_DISTR_VER

ARG CONTRAIL_CONTAINER_TAG
LABEL vendor="Juniper" \
      version=$CONTRAIL_CONTAINER_TAG \
      release="5.1.0"

# Add required license as text file in Liceses directory
RUN mkdir /licenses
COPY licensing.txt /licenses

ARG GENERAL_EXTRA_RPMS=""
ARG YUM_ENABLE_REPOS=""

# this copy should be before yum install
COPY *.repo /etc/yum.repos.d/

RUN YUM_ENABLE_REPOS=$(echo $YUM_ENABLE_REPOS | tr -d '"') && \
    if [[ -n "$YUM_ENABLE_REPOS" ]] ; then \
        echo "INFO: contrail-general-base: enable repos $YUM_ENABLE_REPOS" && \
        yum-config-manager --enable $YUM_ENABLE_REPOS ; \
        yum clean metadata ; \
    fi && \
    yum update -y && \
    yum install -y yum-plugin-priorities iproute less hostname && \
    GENERAL_EXTRA_RPMS=$(echo $GENERAL_EXTRA_RPMS | tr -d '"' | tr ',' ' ') && \
    if [[ -n "$GENERAL_EXTRA_RPMS" ]] ; then \
        echo "INFO: contrail-general-base: install $GENERAL_EXTRA_RPMS" && \
        yum install -y $GENERAL_EXTRA_RPMS ; \
    fi

COPY *.sh /

CMD ["/usr/bin/tail","-f","/dev/null"]
