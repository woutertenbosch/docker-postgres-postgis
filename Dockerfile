FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -yq update &&\
    apt-get -yq install software-properties-common curl &&\
    curl -sL https://deb.nodesource.com/setup_12.x | bash - &&\
    add-apt-repository ppa:osmadmins/ppa &&\
    apt-get -yq install postgresql postgresql-contrib postgis postgresql-12-postgis-3 osm2pgsql wget &&\
	mkdir /data &&\
	chown postgres /data &&\
    echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/12/main/pg_hba.conf &&\
    echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf &&\
	rm -rf /var/lib/apt/lists/*

USER postgres
WORKDIR /data

EXPOSE 5432
CMD ["/usr/lib/postgresql/12/bin/postgres", "-D", "/var/lib/postgresql/12/main", "-c", "config_file=/etc/postgresql/12/main/postgresql.conf"]
