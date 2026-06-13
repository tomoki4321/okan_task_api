# Dockerfile
FROM ruby:3.0.6-bullseye

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev postgresql-client

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]