FROM python:3.12.1-alpine3.19
ENV FLASK_APP=counter.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000
ENV FLASK_DEBUG=True
RUN pip install flask redis MarkupSafe
RUN apk --no-cache add curl
WORKDIR /src
EXPOSE 5000/tcp
# Eliminado para el Ejercicio 4
#HEALTHCHECK CMD curl --fail http://127.0.0.1:5000 || exit 1
#COPY src /src
ENTRYPOINT ["flask", "run"]