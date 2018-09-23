FROM tecadmin/ubuntu-ssh:16.04

RUN apt-get update \
   && apt-get install -y apache2

CMD ["apachectl", "-D", "FOREGROUND"]
EXPOSE 80