FROM ruby:3.0.2

ENV APP_HOME /app

# This is a error handling when to be occurred yarn error.
RUN apt-get update -qq && apt-get install -y build-essential nodejs curl vim postgresql-client && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && apt-get update && apt-get install -y yarn && rm -rf /var/lib/apt/lists/*

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY ./Gemfile $APP_HOME/Gemfile
COPY ./Gemfile.lock $APP_HOME/Gemfile.lock
RUN bundle install
ADD . $APP_HOME

EXPOSE  3000
