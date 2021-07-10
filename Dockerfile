FROM pilosus/pip-license-checker:0.14.0

WORKDIR /usr/src/app
COPY entrypoint.sh /usr/src/app/

ENTRYPOINT ["./entrypoint.sh"]
#CMD ["./entrypoint.sh"]
