FROM mono:latest

RUN apt-get update && apt-get install -y nuget

COPY . /usr/src/app/source
WORKDIR /usr/src/app/source

RUN nuget restore -NonInteractive \
    && msbuild docker.proj /p:Configuration=Debug /p:OutDir=/usr/src/app/build/ \
    && chmod +x docker-entrypoint.sh \
    && cp docker-entrypoint.sh /usr/src/app/build/docker-entrypoint.sh

WORKDIR /usr/src/app/build
EXPOSE 8080 2050 2051

ENTRYPOINT ["./docker-entrypoint.sh"]