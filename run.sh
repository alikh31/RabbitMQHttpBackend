eval "$(docker-machine env default)"

docker rm -f rabbitmqhttp

docker build -t alikh31/rabbitmqhttpauth:latest .

docker run -itd --name rabbitmqhttp --hostname docker-rabbitmqhttp -p '0.0.0.0:10000:5672' -p '0.0.0.0:15672:15672' -p '0.0.0.0:8080:8080' -p '0.0.0.0:1883:1883' -p '0.0.0.0:8883:8883' -p '0.0.0.0:15675:15675' alikh31/rabbitmqhttpauth:latest  bash -E -c '. startup/run.sh'
