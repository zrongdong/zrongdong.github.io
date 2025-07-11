# jekyll_cos_v0.1
FROM jekyll/jekyll:4.2.0
RUN wget https://cosbrowser.cloud.tencent.com/software/coscli/coscli-linux && chmod 755 coscli-linux && mv coscli-linux /usr/local/bin/coscli
COPY Gemfile Gemfile.lock /srv/jekyll/
RUN bundle install
