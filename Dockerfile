# Ubuntu image
#
# Version 0.1

# Pull from Ubuntu


FROM centos:latest

MAINTAINER Wellington Marinho wpmarinho@globo.com

RUN yum update -y
RUN yum localinstall http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm -y
RUN yum install postgresql -y && yum install postgresql-server -y
RUN /etc/init.d/postgresql initdb 


# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
#RUN echo "host all  all    0.0.0.0/0  md5" >> /var/lib/pgsql/9.3/data/pg_hba.conf
#RUN echo "listen_addresses='*'" >> /var/lib/pgsql/9.3/data/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/pgsql"]

#CMD ["/etc/init.d/postgresql initdb"]
# Set the default command to run when starting the container
CMD ["/var/lib/pgsql/9.3/bin/postgres", "-D", "/var/lib/pgsql/9.3/data", "-c", "config_file=/var/lib/pgsql/9.3/data/postgresql.conf"]

