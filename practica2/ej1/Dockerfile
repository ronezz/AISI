# Imagen base para construir la imagen
FROM debian:bookworm-slim 


# Add missing commands
RUN apt-get update \
	&& apt-get install -y wget gcc make \
	&& wget -O redis.tar.gz https://download.redis.io/releases/redis-7.2.4.tar.gz \
	&& mkdir redis \
	&& tar -xzf redis.tar.gz -C redis --strip-components=1 \
	&& make -C redis && make -C redis install \
	&& rm -rf redis \
	&& apt-get purge -y --autoremove wget gcc make \
	&& apt-get clean all

#Variable de entorno 
ENV REDIS_DATA /data 
WORKDIR $REDIS_DATA
RUN groupadd -r redis && useradd -r -g redis redis
USER redis
EXPOSE 6379
ENTRYPOINT ["redis-server", "--protected-mode", "no", "--save", "5", "1"]