MAINTAINER Dimeji Isola <dimeji.isola@gmail.com>
LABEL description="Microsoft SQL (mssql) server on ubuntu with sql server agent"
FROM ubuntu
EXPOSE 1433/tcp
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install curl apt-transport-https libunwind8 adduser libc6 libc++1 gdb bzip2 libnuma1 libjemalloc1 libc++1 gdb libcurl3 \ 
                            openssl python python3 libgssapi-krb5-2 libsss-nss-idmap0 wget apt-transport-https locales gawk sed lsof pbzip2
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN echo deb [arch=amd64] http://packages.microsoft.com/ubuntu/16.04/prod xenial main >> /etc/apt/sources.list.d/sql-server.list
RUN echo deb [arch=amd64] http://packages.microsoft.com/ubuntu/16.04/mssql-server xenial main > /etc/apt/sources.list.d/sql-server.list
RUN apt-get update
RUN ACCEPT_EULA=Y && apt-get install -y mssql-server-agent
RUN apt-get clean && rm -rf /tmp/* && rm -rf /var/lib/apt/lists/*
CMD /opt/mssql/bin/sqlservr