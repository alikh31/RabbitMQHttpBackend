eval "$(docker-machine env default)"

# docker rm -f rabbitmqhttp

docker build -t alikh31/rabbitmqhttpauth:latest .
