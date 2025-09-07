# syntax=docker/dockerfile:1
FROM alpine:3.22

ARG PHANTOM_SOURCE_URL="https://github.com/jhead/phantom/releases/download"
ARG PHANTOM_VERSION=0.5.4
ARG TARGETPLATFORM=linux/amd64

RUN apk add --no-cache bash tini ca-certificates && \
    set -e && \
    case "${TARGETPLATFORM}" in \
      "linux/amd64") BINARY_SUFFIX="" ;; \
      "linux/arm/v5") BINARY_SUFFIX="-arm5" ;; \
      "linux/arm/v6") BINARY_SUFFIX="-arm6" ;; \
      "linux/arm/v7") BINARY_SUFFIX="-arm7" ;; \
      "linux/arm64") BINARY_SUFFIX="-arm8" ;; \
      *) echo "Unsupported platform: ${TARGETPLATFORM}"; exit 1 ;; \
    esac \
    && wget -q "${PHANTOM_SOURCE_URL}/v${PHANTOM_VERSION}/phantom-linux${BINARY_SUFFIX}" -O phantom-linux \
    && chmod +x phantom-linux \
    && addgroup -g 1001 -S phantom \
    && adduser -u 1001 -S phantom -G phantom \
    && mkdir -p /app \
    && mv phantom-linux /app/phantom-linux \
    && chown -R phantom:phantom /app

USER phantom

WORKDIR /app

COPY --chmod=755 --chown=phantom:phantom entrypoint.sh .

ENV SERVER=unknown \
    PHANTOM_VER=latestpre \
    PHANTOM_ARCH=amd64

LABEL maintainer="superman.jason@gmail.com" \
      version="${PHANTOM_VERSION}" \
      description="Makes hosted Bedrock/MCPE servers show up as LAN servers by using phantom"

ENTRYPOINT ["/sbin/tini", "--", "/app/entrypoint.sh"]
