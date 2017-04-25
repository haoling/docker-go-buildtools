FROM golang:1.7.5
# Basic prereq

# Install GPM
RUN git clone https://github.com/pote/gpm.git /tmp/gpm 
RUN cd /tmp/gpm && git checkout tags/v1.4.0 && ./configure && make install
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
RUN cd /tmp/gvp && git checkout tags/v0.3.0 && ./configure &&  make install
RUN rm -rf /tmp/gvp

#RUN go get godoc.org/golang.org/x/tools/cmd/cover
 
# Install helpers

#RUN yum -y install python-setuptools
#RUN easy_install pip && pip install s3cmd

# Add gihtub RSA fingerprint
#RUN mkdir /root/.ssh && touch /root/.ssh/known_hosts && ssh-keyscan -H "github.com" >> /root/.ssh/known_hosts && chmod 600 /root/.ssh/known_hosts
RUN sleep 1
