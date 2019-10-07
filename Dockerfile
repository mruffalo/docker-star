FROM ubuntu:18.04 as BASE
ENV star_version 2.6.1e

MAINTAINER Matt Ruffalo <mruffalo@cs.cmu.edu>

LABEL description="Image for STAR aligner version ${star_version}"

RUN apt-get -y update -y && apt-get -y install --no-install-recommends \
    build-essential \
    zlib1g-dev

# Star aligner
ADD https://github.com/alexdobin/STAR/archive/${star_version}.tar.gz /opt
WORKDIR /opt
RUN tar -xzf ${star_version}.tar.gz
WORKDIR /opt/STAR-${star_version}/source
RUN make && mv STAR /opt

FROM ubuntu:18.04 as RELEASE
ENV star_version 2.6.1e

MAINTAINER Matt Ruffalo <mruffalo@cs.cmu.edu>

LABEL description="Image for STAR aligner version 2.6.1e"

COPY --from=BASE /opt/STAR /usr/local/bin
