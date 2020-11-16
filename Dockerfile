FROM ruby:2.5
RUN apt-get update

WORKDIR . /opt/project

COPY Gemfile ./
RUN bundle install

COPY . /opt/project

