# README

## About
This a RoR project management app. It can keep track of multiple projects, displaying their tasks and statuses, and more.

## Tech stack
This app is built on containers using Docker. The backend is built with Ruby on Rails with the Postgres Database. The frontend will be using Rails views, Bootstrap CSS and JS/JQuery.

* Docker version: 20.10.8
 * Docker Compose version: 1.29.2
 * Ruby version: 3.0.2
 * Rails version: 6.1.4
 * Postgres version: 

## Initial setup
```
# docker-compose.yml

version: "3.9"
services:
  db:
    image: postgres
    volumes:
      - ./tmp/db:/var/lib/postgresql/data
    ports:
      - "5433:5432"
    environment:
      POSTGRES_PASSWORD: password
  web:
    build: .
    command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
    volumes:
      - .:/app
    ports:
      - "3001:3000"
    depends_on:
      - db

# based on: https://docs.docker.com/samples/rails/
```
```
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

# based on: https://noknow.info/it/os/build_with_docker_ruby_on_rails_mysql?lang=en
```
```
# Gemfile
source 'https://rubygems.org'

gem 'rails', '6.1.4'
```
1. Create the above `Dockerfile`, `docker-compose.yml`, the `Gemfile` and an empty `Gemfile.lock` 
2. Create the rails app
`docker-compose run --no-deps web rails new . --force --database=postgresql`
3. Build the image
`docker-compose build`
4. Update the database config
```
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password: password
  pool: 5

development:
  <<: *default
  database: myapp_development


test:
  <<: *default
  database: myapp_test

# based on: https://docs.docker.com/samples/rails/
```
5. Start the containers
`docker-compose up`
6. Create the databases
`docker-compose run web rails db:create`

The initial setup should be complete now

### Local setup
To setup a local instance of the app, make sure Docker and docker-compose are installed, and then follow the instructions in the next section to boot up the application

### Booting up
1. Launch the application
   `docker-compose up # add -d to run as daemon`
2. Create the databases 
   `docker-compose run app rails db:create`
3. Run all migrations
   `docker-compose run app rails db:migrate`
4. Make sure that the application and database containers are running
   `docker-compose ps`
5. The application should now be available at: http://127.0.0.1:3000

### Shutting down
1. Shut down the service
   `docker-compose down`

### Restarting
To restart the application, follow the instructions to shutdown the application and then follow the instructions for booting up the application. The databases will need to be recreated, and every migration will need to be rerun every time the application containers are started.


### Updating the Gemfile
1. Shut down the application containers
2. Add the new gem to the Gemfile
3. Rebuild the docker image so it contains the new gem
   `docker-compose build`
4. Boot up the application


### Running migrations
Migrations can be run while the application containers are running. 
1. Run the migrations
   `docker-compose run app rails db:migrate`
If the application containers are shut down, the migrations will need to be rerun when the application is started up again


### Connecting to PSQL from the PSQL container
1. Access the Postgres container using bash
   `docker exec -it manag3r_db bash`
2. Use the psql client to access Postgres 
   `psql postgres`
Enter the password when prompted


### Connecting to Postgres from the Rails container
1. Access the Rails container using bash
   `docker exec -it manag3r_app bash`
2. Use the psql client to access Postgres on `db` 
   `psql -U postgres -h db `
Enter the password when prompted

### Connecting to Postgres using Rails dbconsole
1. Run the following command to use Rails dbconsole from the web container
   'docker-compose run web rails dbconsole'
