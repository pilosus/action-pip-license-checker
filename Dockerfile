FROM pilosus/pip-license-checker:0.50.0

# Base image uses unpriviledged user
# But we need root to install packages and access files
# mounted by GitHub to the root-owned directories
USER root

# Recommended way to install babashka on Alpine is by getting a static linux binary
RUN wget -qO- https://github.com/babashka/babashka/releases/download/v1.12.206/babashka-1.12.206-linux-amd64-static.tar.gz | tar xzv -C /bin

COPY --chown=1000:1000 entrypoint.clj /usr/src/app/

ENTRYPOINT ["/usr/src/app/entrypoint.clj"]
