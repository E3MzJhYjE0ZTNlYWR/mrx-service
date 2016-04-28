FROM java:openjdk-8u77-jre-alpine

ADD package.zip.enc /home

RUN apk update && \
	apk add openssl unzip bash

EXPOSE 8080

CMD cd /home && \
	openssl enc -d -aes-256-cbc -in package.zip.enc -out package.zip -pass pass:$UNLOCK_KEY && \
	unzip package.zip && \
	mv package/* . && \
	./bin/MemRepoEx	