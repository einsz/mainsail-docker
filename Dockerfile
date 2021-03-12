FROM nginx:alpine

LABEL Maintainer="eins <one@eins.li>" \
      Description="Mainsail Klipper GUI based on nginx with Alpine Linux"

ARG MAINSAIL_VER="latest"

EXPOSE 80

COPY ./default.conf /etc/nginx/conf.d/
COPY ./upstreams.conf /etc/nginx/conf.d/
COPY ./common_vars.conf /etc/nginx/conf.d/

RUN apk --no-cache add zip && \
	mkdir /mainsail && \
	cd /mainsail && \
	if [ "$MAINSAIL_VER" == "latest" ]; \
	then wget -q -O mainsail.zip https://github.com/meteyou/mainsail/releases/latest/download/mainsail.zip; \
	else wget -q -O mainsail.zip https://github.com/meteyou/mainsail/releases/download/${MAINSAIL_VER}/mainsail.zip; \
	fi && \
	unzip mainsail.zip && \
	rm mainsail.zip

COPY ./config.json /mainsail/
	
RUN chown -R nginx:nginx /mainsail

CMD ["nginx", "-g", "daemon off;"]