FROM postgres:18.

COPY start.sh /start.sh
COPY estructura.sql /estructura.sql
COPY datos.sql /datos.sql

RUN chmod +x /start.sh

EXPOSE 5432

ENTRYPOINT ["/start.sh"]
