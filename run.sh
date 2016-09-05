eval "$(docker-machine env default)"

docker build -t alikh31/rabbitmqhttpauth:latest .
docker run -itd -c "node /RabbitMQHttpBackend/index.js" alikh31/rabbitmqhttpauth:latest
