# XML Parser (Test Application)

#### Описание

Проект создан в рамках выполнения тестового задания

##### Ruby version
```
ruby 2.6.1
```

##### Rails version
```
Rails 6.0.1
```

##### Node version
```
Node 8.12.0
```

##### Environment requirements
```
postgresql installed & launched
redis installed & laucned
yarn installed
```

### Первый запуск
```
gem install bundler
bundle install
cd client
yarn install
cd ..
```

Затем подготавливаем базу данных:

```
bundle exec rails db:create
bundle exec rails db:migrate
```

Запуск сервера

```
gem install foreman
foreman start
```

### Тесты
```
rspec
```
