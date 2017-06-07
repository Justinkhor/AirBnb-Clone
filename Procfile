web: bundle exec rails server -p $PORT
web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
redis: redis-server
sidekiq: bundle exec sidekiq -e production -c 5
