# syntax=docker/dockerfile:1
FROM alpine:latest
ARG PHANTOM_SOURCE_URL="https://github.com/jhead/phantom/releases/download"
ARG PHANTOM_VERSION=0.5.4
ARG TARGETPLATFORM=linux/amd64
WORKDIR /app
COPY --chmod=777 entrypoint.sh .

RUN apk add --no-cache bash tini

RUN case "${TARGETPLATFORM}" in \
      "linux/amd64") \
         wget -q ${PHANTOM_SOURCE_URL}/v${PHANTOM_VERSION}/phantom-linux -O phantom-linux ;; \
      "linux/arm/v5") \
         wget -q ${PHANTOM_SOURCE_URL}/v${PHANTOM_VERSION}/phantom-linux-arm5 -O phantom-linux ;; \
      "linux/arm/v6") \
         wget -q ${PHANTOM_SOURCE_URL}/v${PHANTOM_VERSION}/phantom-linux-arm6 -O phantom-linux ;; \
      "linux/arm/v7") \
         wget -q ${PHANTOM_SOURCE_URL}/v${PHANTOM_VERSION}/phantom-linux-arm7 -O phantom-linux ;; \
      "linux/arm64") \
         wget -q ${PHANTOM_SOURCE_URL}/v${PHANTOM_VERSION}/phantom-linux-arm8 -O phantom-linux ;; \
      *) echo "Unsupported platform"; exit 1 ;; \
    esac \
  && chmod +x phantom-linux

ENV SERVER=unknown PHANTOM_VER=latestpre PHANTOM_ARCH=x64
ENTRYPOINT ["/sbin/tini", "--", "/app/entrypoint.sh"]
