FROM ruby:3.0.0

# Add new user an change user
RUN useradd -ms /bin/bash developer
USER developer

# Create and change to work directory
WORKDIR /minesweeper

# Copy dependencies file and install
COPY ["./Gemfile", "./Gemfile.lock", "./"]
RUN bundle install

EXPOSE 3000

ENTRYPOINT [ "./docker/local/rails/entrypoint.sh" ]