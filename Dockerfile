FROM ruby:2.7.2
ENV APP_ROOT /var/www/picture_tweet_app
ENV GEM_HOME /bundle
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG $BUNDLE_PATH
ENV BUNDLE_BIN $BUNDLE_PATH/bin
ENV PATH $APP_ROOT/bin:$BUNDLE_BIN:/root/.local/bin:$PATH

RUN apt-get update -qq && apt-get install -y build-essential nodejs postgresql-client libpq-dev

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
apt-get install -y nodejs

RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

COPY package.json yarn.lock $APP_ROOT/
RUN yarn install

COPY Gemfile Gemfile.lock $APP_ROOT/
RUN bundle install --jobs 4
COPY . $APP_ROOT

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]