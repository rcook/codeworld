FROM debian
MAINTAINER Richard Cook <rcook@rcook.org>

RUN echo '#!/bin/sh\n$*' > /usr/bin/sudo
RUN chmod +x /usr/bin/sudo

RUN apt-get update -y && apt-get install -y \
  python2.7 \
  wget

RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1

COPY base.sh /codeworld/base.sh
COPY install.sh /codeworld/install.sh
RUN cd /codeworld && ./install.sh
RUN mv /codeworld/build /codeworld-build
RUN rm /codeworld/base.sh && \
  rm /codeworld/install.sh
