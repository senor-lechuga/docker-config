# README

The most basic set up application, using docker in conjunction with rails.
The following steps can be taken to create both the docker config, and generate a basic rails application.

* Create a Gemfile with:
```
source 'https://rubygems.org'
gem 'rails', '~> 5.2.0'
```

* Create a Dockerfile with:
```
FROM ruby:2.5.1-slim

RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
       curl \
       gnupg2 \
       postgresql-client \
       nodejs \
       libgmp-dev \
       libpq-dev \
       build-essential \
       patch \
       ssh-client \
       yarn \
       git \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists

# Configure the main working directory
RUN mkdir /app
WORKDIR /app

# Set where to install gems
ENV GEM_HOME /rubygems
ENV BUNDLE_PATH /rubygems

ADD . /app
```

* Create an empty Gemfile.lock

* Finally create your docker-compose.yml file with:
```
version: '3'

services:
  db:
    image: postgres
    volumes:
      - ./tmp/db:/var/lib/postgresql/data

  web:
    build: .
    command: ["./lib/docker/run.sh", "bundle exec rails s"]
    volumes:
      - .:/app
      - web_gems:/rubygems
    environment:
      GEM_HOME: /rubygems
    ports:
      - "3000:3000"
    depends_on:
      - db

volumes:
  web_gems:
```

* Run `docker-compose run web bash`
Then, run
```
bundle exec gem install rails
bundle exec gem install bundler
```

* Rails should now be installed; exit the bash, and run bundle

* Run `docker-compose run web rails new . --force --database=postgresql` and your application should be created within docker
