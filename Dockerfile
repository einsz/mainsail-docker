FROM nginx:alpine

EXPOSE 80

COPY ./default.conf /etc/nginx/conf.d/
COPY ./upstreams.conf /etc/nginx/conf.d/
COPY ./common_vars.conf /etc/nginx/conf.d/

RUN apk --no-cache add zip && \
	mkdir /mainsail && \
	cd /mainsail && \
	wget -q -O mainsail.zip https://github.com/meteyou/mainsail/releases/latest/download/mainsail.zip && \
	unzip mainsail.zip && \
	rm mainsail.zip

COPY ./config.json /mainsail/
	
RUN chown -R nginx:nginx /mainsail

CMD ["nginx", "-g", "daemon off;"]
