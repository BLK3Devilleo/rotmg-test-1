# Usamos una imagen específica de Mono que sea más estable
FROM mono:6.12.0

# Instalamos nuget si no viene por defecto (usualmente ya viene, pero por si acaso)
# Nota: La imagen de Mono 6.12 suele estar basada en Debian Bullseye que no tiene el error 404
RUN apt-get update && apt-get install -y nuget || echo "Nuget already installed"

COPY . /usr/src/app/source
WORKDIR /usr/src/app/source

# Restauramos y buildeamos usando el archivo de proyecto correcto
RUN nuget restore -NonInteractive \
    && msbuild docker.proj /p:Configuration=Debug /p:OutDir=/usr/src/app/build/ \
    && chmod +x docker-entrypoint.sh \
    && cp docker-entrypoint.sh /usr/src/app/build/docker-entrypoint.sh \
    && cp -r resources /usr/src/app/build/resources

WORKDIR /usr/src/app/build
EXPOSE 8080 2050 2051

ENTRYPOINT ["./docker-entrypoint.sh"]