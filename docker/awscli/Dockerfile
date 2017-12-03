FROM catswhocode/awslinux:latest

WORKDIR /usr/src/app

RUN yum -y update && \
    yum clean all


#-----------
# AWS CLI
#-----------

COPY . .

RUN ln -s /usr/bin/python3 /bin/python && \
    easy_install-3.6 pip


RUN pip3 install pip setuptools --upgrade && \
    pip3 install pipenv && \
    pipenv install --deploy --system

RUN printf "\ncomplete -C '/usr/local/bin/aws_completer' aws" >> /root/.bashrc

CMD ["bash"]
