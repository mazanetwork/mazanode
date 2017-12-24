FROM alpine:3.6

RUN apk --no-cache add mongodb
RUN mkdir -v /app
COPY ./mongodb-entrypoint.sh /app/run.sh
COPY mongodb-entrypoint_firstrun.sh /app/first_run.sh
RUN chmod +x /app/*.sh \
     && touch /.firstrun \
     &&  chown -R mongodb /app 


ENTRYPOINT ["/app/run.sh"]
