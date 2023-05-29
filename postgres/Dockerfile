ARG PG_MAJOR=15
FROM postgres:$PG_MAJOR

# Disable automatic cache cleanup so we can persist the apt cache between build runs
RUN rm -f /etc/apt/apt.conf.d/docker-clean; \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache

WORKDIR /tmp

RUN --mount=type=cache,target=/var/cache/apt  --mount=type=cache,target=/var/lib/apt \
    apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    nano \
    wget \
    git \
    build-essential \
    ca-certificates \
    postgresql-server-dev-$PG_MAJOR

RUN git clone --branch v0.4.2 --depth 1 https://github.com/pgvector/pgvector.git

WORKDIR /tmp/pgvector

RUN make clean && \
    make OPTFLAGS="" && \
    make install && \
    mkdir /usr/share/doc/pgvector && \
    cp LICENSE README.md /usr/share/doc/pgvector && \
    rm -r /tmp/pgvector && \
    apt-get remove -y build-essential postgresql-server-dev-$PG_MAJOR wget git && \
    apt-get autoremove -y