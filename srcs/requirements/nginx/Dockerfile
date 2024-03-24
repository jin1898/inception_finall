FROM debian:bullseye

RUN apt-get update -y
RUN apt-get install nginx openssl -y

COPY ./tools/script.sh /

CMD [ "./script.sh" ]

EXPOSE 443
