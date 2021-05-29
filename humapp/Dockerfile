FROM ruby:2.6.5

# make and use working directory
WORKDIR /appcode

# Copy all the application's files
COPY . /appcode

# Run bundle install to install the Ruby dependencies.
RUN gem install bundler

RUN bundle install

# Install Yarn.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Run yarn install to install JavaScript dependencies.
RUN yarn install --check-files

EXPOSE 3001

# run when this container starts.
CMD ["thin", "start", "--ssl", "--ssl-key-file", "localhost.key", "--ssl-cert-file", "localhost.crt", "-p", "3001"]
