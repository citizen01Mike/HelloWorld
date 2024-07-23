# Use the official Ruby image from the Docker Hub
FROM ruby:2.7.2-alpine

# Install dependencies

RUN ap add --update \
    build-base \
    mariadb-dev \
    sqlite-dev \
    nodejs \
    tzdata \    
    && rm -rf /var/cache/apk/*
  RUN gem install bundler

  WORKDIR /app

  COPY . /app
  COPY Gemfile Gemfile.lock ./

  RUN bundle installation
  
  EXPOSE 3000

  CMD rm -f tmp/pids/server.pid & rails s -b "0.0.0.0"
  