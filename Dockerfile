FROM alpine
RUN apk add ruby-bundler curl-dev ruby-dev build-base
COPY Gemfile /
RUN bundle install
COPY app.rb /
COPY main.rb /
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ENV AWS_ACCESS_KEY_ID $AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY $AWS_SECRET_ACCESS_KEY
CMD sh -c "ruby app.rb"
