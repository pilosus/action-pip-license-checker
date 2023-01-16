FROM pilosus/pip-license-checker:0.42.1

# Base image uses unpriviledged user
# But we need root to install bash and access files
# mounted by GitHub to the root-owned directories
USER root
RUN apk add --no-cache bash

COPY --chown=1000:1000 entrypoint.sh /usr/src/app/

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
