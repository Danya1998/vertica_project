FROM ruby:2.5

RUN apt-get update
RUN gem install bundle && gem install cucumber

COPY . /opt/project/

WORKDIR /opt/project/

COPY Gemfile /opt/project/

RUN bundle install

ENTRYPOINT ["bash", "start.sh"]