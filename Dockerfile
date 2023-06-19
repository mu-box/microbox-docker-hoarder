FROM mubox/base

# Create directories
RUN mkdir -p \
  /var/log/gomicro \
  /var/microbox \
  /opt/microbox/hooks

# Install and rsync
RUN apt-get update -qq && \
    apt-get install -y rsync && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

# Download hoarder
RUN curl \
      -f \
      -k \
      -o /usr/local/bin/hoarder \
      https://s3.amazonaws.com/tools.microbox.cloud/hoarder/linux/amd64/hoarder && \
    chmod 755 /usr/local/bin/hoarder

# Download md5 (used to perform updates in hooks)
RUN curl \
      -f \
      -k \
      -o /var/microbox/hoarder.md5 \
      https://s3.amazonaws.com/tools.microbox.cloud/hoarder/linux/amd64/hoarder.md5

# Download slurp
RUN curl \
      -f \
      -k \
      -o /usr/local/bin/slurp \
      https://s3.amazonaws.com/tools.microbox.cloud/slurp/linux/amd64/slurp && \
    chmod 755 /usr/local/bin/slurp

# Download md5 (used to perform updates in hooks)
RUN curl \
      -f \
      -k \
      -o /var/microbox/slurp.md5 \
      https://s3.amazonaws.com/tools.microbox.cloud/slurp/linux/amd64/slurp.md5

# Install hooks
RUN curl \
      -f \
      -k \
      https://s3.amazonaws.com/tools.microbox.cloud/hooks/hoarder-stable.tgz \
        | tar -xz -C /opt/microbox/hooks

# Download hooks md5 (used to perform updates)
RUN curl \
      -f \
      -k \
      -o /var/microbox/hooks.md5 \
      https://s3.amazonaws.com/tools.microbox.cloud/hooks/hoarder-stable.md5

WORKDIR /data

# Run runit automatically
CMD [ "/opt/gomicro/bin/microinit" ]
