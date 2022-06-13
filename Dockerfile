FROM ruby:3.1.2

RUN mkdir -p /usr/src/crypto_app
WORKDIR /usr/src/crypto_app
COPY . .

RUN apt-get update -qq \
    && apt-get install -y build-essential libpq-dev nodejs npm imagemagick mariadb-client vim cron \
    && chmod +x entrypoint.sh \
    && gem install bundler

EXPOSE 3000

# for keep alive the container without any rails process. Allows to run the test suite, execute commands, run console...
# ENTRYPOINT ["tail", "-f", "/dev/null"]

ENTRYPOINT ["./entrypoint.sh"]
