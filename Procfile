web: cd client && yarn start
api: bundle exec rails s -p 3000
parser: QUEUE=xml_parser_* bundle exec rake environment resque:work
scheduler: rake environment resque:scheduler
