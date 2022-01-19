FROM ip-10-0-0-10:5000/free5gc-k8s/f5gc-base:v3.0.6 AS builder
FROM ubuntu:20.04
LABEL description="Free5GC open source 5G Core Network" \
    version="Stage 3"

ENV F5GC_MODULE smf
ARG DEBUG_TOOLS

# Install debug tools ~ 100MB (if DEBUG_TOOLS is set to true)
RUN if [ "$DEBUG_TOOLS" = "true" ] ; then apk add -U vim strace net-tools curl netcat-openbsd ; fi

# Install dependencies
RUN apt-get update \
    && apt-get install -y iproute2

# Set working dir
WORKDIR /free5gc
RUN mkdir -p config/ log/ support/TLS/ ${F5GC_MODULE}/

# Copy executable and default certs
COPY --from=builder /free5gc/${F5GC_MODULE} ./${F5GC_MODULE}
COPY --from=builder /free5gc/support/TLS/${F5GC_MODULE}.pem ./support/TLS/
COPY --from=builder /free5gc/support/TLS/${F5GC_MODULE}.key ./support/TLS/

# Move to the binary path
WORKDIR /free5gc/${F5GC_MODULE}

# Config files volume
VOLUME [ "/free5gc/config" ]

# Certificates (if not using default) volume
VOLUME [ "/free5gc/support/TLS" ]

ENTRYPOINT [ "./smf" ]
CMD [ "-smfcfg", "../config/smfcfg.conf", "--uerouting", "../config/uerouting.yaml" ]

# Exposed ports
EXPOSE 29502/tcp
EXPOSE 8805/udp

