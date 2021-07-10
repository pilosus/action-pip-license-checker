FROM pilosus/pip-license-checker:0.14.0

COPY entrypoint.sh /usr/src/app/

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
#CMD ["/usr/src/app/entrypoint.sh"]
