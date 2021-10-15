FROM postgres:13
EXPOSE 5432

COPY init-count-bits.sh /docker-entrypoint-initdb.d/

RUN apt update && \
	apt -y install git libpq-dev postgresql-server-dev-13 gcc make && \
	git clone https://github.com/sldab/count-bits.git /opt/count-bits && \
	cd /opt/count-bits && \
	make && \
	sed -i.bak 's/create_functions: install/create_functions:/' Makefile && \
	make install && \
	apt -y remove git libpq-dev postgresql-server-dev-13 && \
	apt -y autoremove && \
	apt -y clean
