FROM clover/base AS base

RUN groupadd \
        --gid 50 \
        --system \
        www \
 && useradd \
        --home-dir /var/www \
        --no-create-home \
        --system \
        --shell /bin/false \
        --uid 50 \
        --gid 50 \
        www

FROM library/debian:stable-slim AS build

ENV LANG=C.UTF-8 \
    SANDBOX_ROOT=/

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y wget openssl ca-certificates

ADD https://github.com/alemax-xyz/misc-tools.git#main /usr/local/bin/

RUN mkdir -p /build /rootfs

WORKDIR /build

COPY build/ .

COPY --from=clover/common:latest /var/lib/packages/ var/lib/packages/

RUN apt-sandbox --install --verstamp \
        --apt-config \
            APT::Install-Recommends=false \
            APT::Get::Upgrade==false \
        --repository . \
        --keyring . \
        --installed var/lib/packages \
        --obsolete packages.obsolete \
        --required packages.required

WORKDIR /rootfs

RUN rm -rf \
        etc/default \
        etc/init.d \
        etc/logrotate.d \
        etc/nginx/conf.d \
        etc/nginx/modules* \
        etc/nginx/sites* \
        etc/nginx/snippets* \
        etc/ufw \
        usr/bin/routel \
        usr/include \
        usr/lib/systemd \
        usr/share/apport \
        usr/share/bash* \
        usr/share/doc \
        usr/share/lintian \
        usr/share/locale \
        usr/share/man \
        usr/share/vim \
 && sed -i -r \
        -e 's,^[[:space:]]*[#;]+.*$,,g' \
        -e 's,[[:space:]]+, ,g' \
        -e '/^[[:space:]]*$/d' \
        etc/nginx/* \
        etc/netconfig \
        usr/share/iproute2/*


COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/
COPY rootfs/ .

WORKDIR /


FROM clover/common

ENV LANG=C.UTF-8

COPY --from=build /rootfs /

EXPOSE 80 443
