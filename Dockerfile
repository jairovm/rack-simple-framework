FROM ruby:2.4.2

ENV APP_HOME /webapps/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ENV RACK_ENV production

# Copy the Gemfile as well as the Gemfile.lock and install the RubyGems.
# This is a separate step so the dependencies will be cached unless changes to
# one of those two files are made.
COPY Gemfile* ./

RUN bundle install \
    --deployment \
    --without development test \
    --jobs 3 \
    --retry 5

# Copy the main application.
COPY . ./

CMD ["sh", "-c", "rackup -o 0.0.0.0"]
