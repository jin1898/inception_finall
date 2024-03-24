FROM debian:bullseye

RUN apt-get update -y
RUN apt-get install mariadb-server -y

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/script.sh /
CMD ["./script.sh"]

EXPOSE 3306
