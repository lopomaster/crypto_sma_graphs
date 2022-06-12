FROM ruby:3.1.2

RUN mkdir -p /usr/src/crypto_app
WORKDIR /usr/src/crypto_app
COPY . .

RUN apt-get update -qq \
    && apt-get install -y build-essential libpq-dev nodejs npm imagemagick mariadb-client vim \
    && npm install -g bower \
    && chmod +x entrypoint.sh \
    && echo "deb http://deb.debian.org/debian unstable main" >> /etc/apt/sources.list \
    && apt-get update -qq \
    && apt-get install -y libmariadb3/unstable \
    && sed -i '$d' /etc/apt/sources.list


CMD mkdir -p tmp/pids && \
    bundle exec rails db:create && \
    bundle exec rails db:migrate && \
    bundle exec rake db:seed && \
    bundle exec puma -C config/puma.rb

CMD whenever --update-crontab

EXPOSE 3000

ENTRYPOINT ["tail", "-f", "/dev/null"]


