FROM bradallen/ruby-2.2.0

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y libpq-dev libreadline-dev mysql-client libmysqlclient-dev nodejs

RUN gem install bundler

RUN mkdir -p /ruby/emptyscope
RUN chown ruby:ruby /ruby/emptyscope

WORKDIR /ruby/emptyscope

ADD Gemfile /ruby/emptyscope/Gemfile
ADD Gemfile.lock /ruby/emptyscope/Gemfile.lock
RUN chown ruby:ruby /ruby/emptyscope/Gemfile /ruby/emptyscope/Gemfile.lock

USER ruby

RUN bundle install --without development test

USER root

ADD ./ /ruby/emptyscope

RUN chown -R ruby:ruby /ruby/emptyscope

EXPOSE 9292

USER ruby

CMD bundle exec puma -C config/puma.rb