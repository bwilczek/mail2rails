```
# send example email assuming that docker-compose up -d was invoked before
docker exec mail2rails_web_1 rails runner -e production bin/send_example.rb
```
