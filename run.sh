eval "$(docker-machine env default)"

docker rm -f rabbitmqhttp

# docker build -t alikh31/rabbitmqhttpauth:latest .

docker run --name rabbitmqhttp --hostname docker-rabbitmqhttp -p '0.0.0.0:5672:5672' -p '0.0.0.0:15672:15672' -p '0.0.0.0:8080:8080' alikh31/rabbitmqhttpauth:latest  bash -E -c '. startup/run.sh'
