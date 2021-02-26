# Creacion de imagen docker para desplegar una aplicación
FROM ubuntu:16.04
MAINTAINER "santosgarrido"
# Ejecuta estos comandos a partir de la imagen ubuntu, para crear una nueva imagen
RUN apt-get update
RUN apt-get install python python-pip -y
RUN apt-get install net-tools -y

RUN mkdir /opt/app

# Copia el código de nuestro proyecto, dentro de la imagen a crear
COPY src/* /opt/app/
COPY requirements.txt /opt/app/
COPY docker-entrypoint.sh /

RUN pip install pytest
RUN pip install flask
#RUN pip install -r /opt/app/requirements.txt

# Cuando arranque como contenedor ejecutará este script, con todo lo queremos ejecutar en arranque del contenedor
ENTRYPOINT "/docker-entrypoint.sh"
