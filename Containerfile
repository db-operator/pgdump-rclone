FROM postgres:18-alpine

RUN apk --no-cache add \
        curl \
        bash \
        rclone

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /backup
ENTRYPOINT /entrypoint.sh
