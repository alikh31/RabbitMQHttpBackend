FROM rabbitmq:latest

# get wget
RUN apt-get update \
	&& apt-get install -y wget

# download rabbitmq_web_mqtt plugin
RUN wget http://www.rabbitmq.com/community-plugins/v3.6.x/rabbitmq_web_mqtt-3.6.x-3b6a09bb.ez -P /plugins

# download rabbitmq_auth_backend_http plugin
RUN wget http://www.rabbitmq.com/community-plugins/v3.6.x/rabbitmq_auth_backend_http-3.6.x-3dfe5950.ez -P /plugins

# remove and download rabbitmq config file
RUN rm /etc/rabbitmq/rabbitmq.config

RUN echo '[{rabbit, [{auth_backends, [rabbit_auth_backend_internal, rabbit_auth_backend_http]}]},\
  	{rabbitmq_auth_backend_http,\
  	[{user_path,     "http://localhost:8080/auth/user"},\
		{vhost_path,    "http://localhost:8080/auth/vhost"},\
		{resource_path, "http://localhost:8080/auth/resource"}]},\
		{rabbitmq_mqtt,\
		[{vhost,     "dev"},\
		{vhost_path,    "http://localhost:8080/auth/vhost"},\
		{exchange,"mqtt-broker:pubsub"}]}]. ' > /etc/rabbitmq/rabbitmq.config

# enabling needed plugings
RUN rabbitmq-plugins enable rabbitmq_management
RUN rabbitmq-plugins enable rabbitmq_auth_backend_ldap
RUN rabbitmq-plugins enable rabbitmq_management_visualiser
RUN rabbitmq-plugins enable rabbitmq_mqtt
RUN rabbitmq-plugins enable rabbitmq_web_mqtt
RUN rabbitmq-plugins enable rabbitmq_auth_backend_http

# installing node js npn and git
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        python \
        rsync \
        software-properties-common \
        wget \
    && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 4.4

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && mkdir /usr/local/nvm/versions \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \

ENV NODE_PATH /usr/local/nvm/versions/v4.4.7/lib/node_modules
ENV PATH      /usr/local/nvm/versions/v4.4.7/bin:$PATH

RUN mkdir startup

RUN echo "rabbitmq-server -detached && /bin/sh -c 'sleep 15s' && rabbitmqctl add_vhost dev && git clone https://github.com/alikh31/RabbitMQHttpBackend.git && cd RabbitMQHttpBackend && npm i && node index.js" > /startup/run.sh

EXPOSE 15672 1883 8883 15675 8080
