# How to install
## Initialize
- `docker-compose build`
- `docker-compose run web rails db:create`

## Migration for other environments
- `docker-compose run web rails db:migrate`
- `docker-compose run web rails db:migrate RAILS_ENV=test`

## Starting
- `docker-compose up`

---

## How to deploy server
### SSH to server with user root
- `root@167.71.195.60`

### Switch to user deploy
- `su - deploy`

### Pull code from github
- `cd /var/www/blog_api`
- `git pull origin dev`
- `docker-compose down`
- `docker-compose up`

### Restart server
- `exit`
- `service nginx restart`
