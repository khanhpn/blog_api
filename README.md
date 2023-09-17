# How to install
## Initialize
- `docker-compose build`
- `docker-compose run web rails db:create`

## Migration for other environments
- `docker-compose run web rails db:migrate`
- `docker-compose run web rails db:migrate RAILS_ENV=test`

## Starting
- `docker-compose up`
