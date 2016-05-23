FROM ruby:2.2

RUN apt-get update
RUN apt-get install -y nodejs mysql-client telnet mailutils

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN bundle install

EXPOSE 25
EXPOSE 3000
