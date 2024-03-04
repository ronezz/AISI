FROM debian:bookworm-slim as BUILD

RUN apt-get update \
	&& apt-get install -y wget make gcc \
	&& wget -O redis.tar.gz https://download.redis.io/releases/redis-7.2.4.tar.gz \
	&& mkdir redis \
	&& tar -xzf redis.tar.gz -C redis --strip-components=1	\
	&& make	-C redis \
	&& make	-C redis install

FROM frolvlad/alpine-glibc

ENV REDIS_DATA=/data
WORKDIR	$REDIS_DATA 
RUN addgroup -S redis && adduser -S redis -G redis \
	&& chown redis:redis $REDIS_DATA
USER redis
EXPOSE 6379
COPY --from=BUILD /usr/local/bin/redis-server /usr/local/bin/
ENTRYPOINT ["redis-server", "--protected-mode", "no", "--save", "5", "1"]