FROM centos:centos6
MAINTAINER Viktor Miroshnikov <me@vmiroshnikov.com>
# Basic prereq
RUN yum -y update
RUN yum -y install curl git mercurial bzr gcc glibc-devel which tar
# Install Go
RUN curl -s https://storage.googleapis.com/golang/go1.3.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:/go/bin:$PATH
ENV GOPATH /go

# Install GPM
RUN git clone https://github.com/pote/gpm.git /tmp/gpm 
RUN cd /tmp/gpm && git checkout tags/v1.2.3 && ./configure && make install
RUN rm -rf /tmp/gpm

# Install GPM-GIT
RUN git clone  https://github.com/technosophos/gpm-git.git /tmp/gpm-git 
RUN cd /tmp/gpm-git && git checkout tags/v1.0.1 && make install
RUN rm -rf /tmp/gpm-git

# Install GPM-LOCAL
RUN git clone  https://github.com/technosophos/gpm-local.git /tmp/gpm-local 
RUN cd /tmp/gpm-local && git checkout tags/1.0.0 && make install
RUN rm -rf /tmp/gpm-local

# Install GVP
RUN git clone https://github.com/pote/gvp.git /tmp/gvp 
RUN cd /tmp/gvp && git checkout tags/0.0.4 && ./configure &&  make install
RUN rm -rf /tmp/gvp

RUN go get code.google.com/p/go.tools/cmd/cover

# Install helpers

RUN yum -y install python-setuptools
RUN easy_install pip && pip install s3cmd

# Add gihtub RSA fingerprint
RUN mkdir /root/.ssh && touch /root/.ssh/known_hosts && ssh-keyscan -H "github.com" >> /root/.ssh/known_hosts && chmod 600 /root/.ssh/known_hosts
RUN sleep 1

# Install localdynamodb
EXPOSE 8000:8000
RUN yum install curl -y -q
RUN curl -s -L -o localdynamodb.tar.gz http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest
RUN tar -xvzf localdynamodb.tar.gz
# this is just a random version of java any newer version should also work
RUN yum install java-1.7.0-openjdk java-1.7.0-openjdk-devel -y -q
RUN echo run this container with: java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -port 8000 -inMemory
