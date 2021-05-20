set -xe
rm main.sh

git clone https://github.com/Nakilon/esolang.git
cd esolang

apk add ruby-dev curl-dev build-base ruby-etc
gem install bundler
bundle install
bundle exec ruby main.rb

gcloud auth activate-service-account --key-file=/temp.json
rm /temp.json
gsutil cp esolangcategories.json gs://esolang.www.nakilon.pro/
