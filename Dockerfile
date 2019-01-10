FROM ruby:2.6-slim
MAINTAINER Eric McNiece <emcniece@gmail.com>

ENV CHECKOUT_ID=d315775c4f56417acf406969990edd6e723b260e

RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential git \
    # for postgres
    libpq-dev \
    # for nokogiri
    libxml2-dev libxslt1-dev \
    # for capybara-webkit
    libqtwebkit4 libqt4-dev xvfb \
    python python-dev python-pip python-virtualenv \
    nodejs \
    # install boarding
    && mkdir -p boarding && cd boarding \
    && git clone https://github.com/fastlane/boarding.git . \
    && git checkout $CHECKOUT_ID \
    && gem install bundler \
    && bundle install \
    # cleanup
    && apt-get remove -y git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /boarding
CMD bundle exec puma -C config/puma.rb
