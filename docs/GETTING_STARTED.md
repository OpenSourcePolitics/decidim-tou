# 👋 Getting started with our decidim-tou

### Requirements
- **Ruby** 2.7.5
- **Bundler** 2.3.13
- **PostgreSQL** 14+
- **Node** 16.9.1
- **npm** 7.21.1
- **yarn** 1.22.19
- **Imagemagick**
- **Chrome browser and chromedriver**

### Installation

1. Clone repository
```bash
git clone https://github.com/OpenSourcePolitics/decidim-tou/
cd decidim-tou
```

2. Install project dependencies

Install Ruby dependencies using `bundler` :

> bundle install

3. Setup database locally

Create the database, migrates and create seeds.

```
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

> **Warning**
> If rake command returns an error, ensure your PostgreSQL service is running : `lsof -i:5432`

5. Installing JS dependencies

We use `yarn` to install dependencies

> yarn install

6. **You should now be able to navigate locally !**

You can now start your server locally by executing `bundle exec rails s` and accessing URL http://localhost:3000/  🎊

### Testing

Testing is very important, in the decidim-tou we implement existing specs from Decidim to prevent regression. Then we update specs to match customizations made in repository.

If you want to execute specs you can setup your test environment `bundle exec rake test:setup` then use Rspec `bundle exec rspec spec`