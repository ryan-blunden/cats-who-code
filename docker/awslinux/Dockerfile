FROM amazonlinux:latest

ENV LC_CTYPE=en_US.utf8
ENV LC_ALL=en_US.utf8
ENV LANG=en_US.utf8
ENV PYTHONUNBUFFERED=1

RUN yum -y update && \
    yum -y install python36 ncomplete jq less which -y && \
    yum clean all
