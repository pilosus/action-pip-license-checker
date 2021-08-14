FROM pilosus/pip-license-checker:0.21.0

COPY entrypoint.sh /usr/src/app/

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
