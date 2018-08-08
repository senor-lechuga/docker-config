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
