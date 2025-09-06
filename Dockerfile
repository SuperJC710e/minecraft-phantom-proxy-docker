FROM alpine:latest

ARG PHANTOM_VERSION=0.5.4

WORKDIR /app

COPY --chmod=777 entrypoint.sh .

RUN apk add --no-cache bash tini \
    && wget -q https://github.com/jhead/phantom/releases/download/v${PHANTOM_VERSION}/phantom-linux \
    && wget -q https://github.com/jhead/phantom/releases/download/v${PHANTOM_VERSION}/phantom-linux-arm5 \
    && wget -q https://github.com/jhead/phantom/releases/download/v${PHANTOM_VERSION}/phantom-linux-arm6 \
    && wget -q https://github.com/jhead/phantom/releases/download/v${PHANTOM_VERSION}/phantom-linux-arm7 \
    && wget -q https://github.com/jhead/phantom/releases/download/v${PHANTOM_VERSION}/phantom-linux-arm8 \
    && mv phantom-linux phantom-linux-x64 \
    && chmod +x phantom-linux*

ENV SERVER=unknown; \
    PHANTOM_VER=latestpre; \
    PHANTOM_ARCH=x64

ENTRYPOINT ["/sbin/tini", "--", "/app/entrypoint.sh"]
