FROM postgres:alpine

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB university-session1

COPY db/university-session1.sql /docker-entrypoint-initdb.d/10-create-db.sql