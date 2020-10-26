# Dockerfile

# Include the Ruby base image (https://hub.docker.com/_/ruby)
# in the image for this application, version 2.7.1.
FROM ruby:2.7.1

# Put all this application's files in a directory called /buycotest.

WORKDIR /buycotest
COPY . /buycotest

# Run this command. RUN can be used to run anything. In our
# case we're using it to install our dependencies.
RUN bundle install

# Tell Docker to listen on port 8000.
EXPOSE 8000

# Tell Docker that when we run "docker run", we want it to
COPY docker-entrypoint.sh /
ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
CMD ["bundle", "exec", "ruby", "server.rb"]
