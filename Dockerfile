FROM pilosus/pip-license-checker:0.38.0

# Install deps as root user
USER root
RUN apk add --no-cache bash

# Copy files
COPY --chown=1000:1000 entrypoint.sh /usr/src/app/
CMD ["/usr/src/app/entrypoint.sh"]
