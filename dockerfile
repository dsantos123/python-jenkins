# Creacion de imagen docker para desplegar una aplicación
FROM ubuntu:20.04
MAINTAINER "santosgarrido"
# Ejecuta estos comandos a partir de la imagen ubuntu, para crear una nueva imagen
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install python python3-pip -y
RUN apt-get install net-tools -y

RUN mkdir /opt/app

# Copia el código de nuestro proyecto, dentro de la imagen a crear
COPY src/* /opt/app/
COPY requirements.txt /opt/app/
COPY docker-entrypoint.sh /

RUN pip3 install pytest
RUN pip3 install flask
#RUN pip3 install -r /opt/app/requirements.txt

# Cuando arranque como contenedor ejecutará este script, con todo lo queremos ejecutar en arranque del contenedor
ENTRYPOINT "/docker-entrypoint.sh"
