# Introduction

`mail2rails` is a simple SMTP server, that instead of relaying messages stores them inside local `mysql` database and exposes them over HTTP API. 
Complete solution consists of 3 `docker` containers wired up together using `docker-compose`. 
2 of these container use the same image specified in `Dockerfile` that can be found in current directory. First one is used to act as SMTP server (port 25), second one as HTTP server (port 3000).
This approach effectively means 2 instance of `rails` running at the same time, so when launching container without attached `docker-compose` be sure that configuration (env + db) is in sync for these two.
The reasoning behind this approach is that it is recommended that containers are specific to one service, and the same `ActiveRecord` code can be used on both ends (SMTP/HTTP).

# Launching it

1. Make sure to have a machine with available port 25 and some friendly domain name for your users. For example `testmail.myorg.intranet`.
2. `git clone` this repo
3. run `docker-compose up -d` # 3 containers should be up and running in background after ~20 seconds
4. send email to `john@testmail.myorg.intranet` from some other machine
5. URLs
   * `http://testmail.myorg.intranet:3000/inbox/john` messages for `john`
   * `http://testmail.myorg.intranet:3000/api/inbox/john` messages for `john` as `JSON`
   * `http://testmail.myorg.intranet:3000/inbox/john/message/1` message with ID=1 for `john`
   * `http://testmail.myorg.intranet:3000/api/inbox/john/message/1` message with ID=1 for `john` as `JSON`
6. run `docker-compose down` when app is not needed anymore

# Useful commands

```
# launch application in debug mode to work on the code in CWD while it runs
# in this mode mysql is exposed as root:root@testmail.myorg.intranet:6603
docker-compose -f docker-compose-dev.yml up -d

# send example email to inbox `someone` (mind the name of the container and environment)
docker exec mail2rails_web_1 rails runner -e production bin/send_example.rb

# login to running web container
docker exec -it mail2rails_web_1 bash
tail -f log/production.log

# if there's a need to rebuild docker container image after some development before launching production mode use:
docker-compose build
```

# Gotchas

* Application is NOT persistent. After every down/up stored emails will be lost. To prevent it learn about mounting volumes to docker containers and alter `docker-compose.yml` for `mysql` service.
* Secure aspect of this app was not seriously taken into consideration. Do not expose it to public traffic, use it to test emails while developing your systems in the intranet.
