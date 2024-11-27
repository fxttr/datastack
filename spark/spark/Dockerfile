# syntax=docker/dockerfile:1
FROM sparkbase:latest

COPY ./scripts/entrypoint.sh .
RUN chmod u+x ./entrypoint.sh 

ENTRYPOINT [ "./entrypoint.sh" ]