FROM alpine:3.20

# ---- set Hugo version here ----
ARG HUGO_VERSION=0.162.1

# Install dependencies
RUN apk add --no-cache \
    curl \
    git \
    libc6-compat \
    libstdc++ \
    ca-certificates

# Download and install Hugo Extended
RUN curl -L -o /tmp/hugo.tar.gz \
    https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz \
    && tar -xzf /tmp/hugo.tar.gz -C /tmp \
    && mv /tmp/hugo /usr/local/bin/hugo \
    && chmod +x /usr/local/bin/hugo \
    && rm -rf /tmp/*

WORKDIR /src

EXPOSE 1313

ENTRYPOINT ["hugo"]