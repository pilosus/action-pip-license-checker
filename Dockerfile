FROM pilosus/pip-license-checker:0.28.1

COPY entrypoint.sh /usr/src/app/

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
