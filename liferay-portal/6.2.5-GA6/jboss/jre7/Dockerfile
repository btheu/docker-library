FROM java:7-jre

MAINTAINER Benoit Theunissen <benoit.theunissen@gmail.com>

ENV LIFERAY_PRODUCT liferay-portal

ENV LIFERAY_HOME /usr/local/$LIFERAY_PRODUCT
ENV PATH $LIFERAY_HOME/bin:$PATH
RUN mkdir -p "$LIFERAY_HOME"
WORKDIR $LIFERAY_HOME

RUN apt-get update && apt-get install -y curl unzip && rm -rf /var/lib/apt/lists/*

ENV LIFERAY_MAJOR 6

ENV LIFERAY_VERSION 6.2.5-GA6

ENV LIFERAY_ZIP_URL https://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.2.5%20GA6/liferay-portal-jboss-6.2-ce-ga6-20160112152609836.zip/download

RUN set -x \
	\
	&& curl -fSL "$LIFERAY_ZIP_URL" -o liferay.zip \
	&& unzip liferay.zip

RUN mv liferay-portal-6.2-ce-ga6/* . \
  && rm -rf liferay-portal-6.2-ce-ga6 \
	&& rm -f  jboss-7.1.1/bin/*.bat \
	&& rm liferay.zip
