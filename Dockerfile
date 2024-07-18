# Use the official Ruby image from the Docker Hub
FROM ruby:2.7

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set an environment variable for the installation path
ENV INSTALL_PATH /helloworld

# Create and set work directory
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

# Ensure gems are installed in a specific path
ENV GEM_HOME="/bundle"
ENV PATH="/bundle/bin:$PATH"

# Copy Gemfile and Gemfile.lock before other files to utilize Docker cache
COPY Gemfile Gemfile.lock ./

# Install Gem dependencies
RUN gem install bundler:2.2.14
RUN bundle install

# Copy the rest of the application code
COPY . ./

# Precompile assets (if applicable)
RUN bundle exec rake assets:precompile

# Expose port 3000 to the Docker host
EXPOSE 3000

# Set the entrypoint to start the server
CMD ["rails", "server", "-b", "0.0.0.0"]
