FROM nanobox/runit

# Create directories
RUN mkdir -p \
  /var/log/gonano \
  /var/nanobox \
  /opt/nanobox/hooks

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
      https://s3.amazonaws.com/tools.nanopack.io/hoarder/linux/amd64/hoarder && \
    chmod 755 /usr/local/bin/hoarder

# Download md5 (used to perform updates in hooks)
RUN curl \
      -f \
      -k \
      -o /var/nanobox/hoarder.md5 \
      https://s3.amazonaws.com/tools.nanopack.io/hoarder/linux/amd64/hoarder.md5

# # Install hooks
# RUN curl \
#       -f \
#       -k \
#       https://s3.amazonaws.com/tools.nanobox.io/hooks/hoarder-stable.tgz \
#         | tar -xz -C /opt/nanobox/hooks
#
# # Download hooks md5 (used to perform updates)
# RUN curl \
#       -f \
#       -k \
#       -o /var/nanobox/hooks.md5 \
#       https://s3.amazonaws.com/tools.nanobox.io/hooks/hoarder-stable.md5

# Run runit automatically
CMD [ "/opt/gonano/bin/nanoinit" ]
