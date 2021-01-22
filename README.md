<h1>Hello Rails + CORS for HTML</h1>
- Cross Origin Resource Sharing = CORS
- allow our api to send back data in json format that we can then use in our html front-end.

---

<h2>Table of Contents</h2>

- [create a new app-back-end-api](#create-a-new-app-back-end-api)
- [add two models](#add-two-models)
- [create a new dtabase and schema](#create-a-new-dtabase-and-schema)
- [add new seed data](#add-new-seed-data)
- [add a new serializer class](#add-a-new-serializer-class)
- [get the app-back-end-html](#get-the-app-back-end-html)
- [references](#references)


---

## create a new app-back-end-api
```bash
EXISTING_APP_ID=app-back-end-api && NEW_APP_ID=app-back-end-html && \
git clone -b ${EXISTING_APP_ID} https://github.com/cnruby/rails-demo-cors ${NEW_APP_ID} && \
cd ${NEW_APP_ID} && \
git checkout -b ${NEW_APP_ID}
```

```bash
nano ./Gemfile.rb
```
```bash
# FILE (./Gemfile.rb)
...
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
gem 'active_model_serializers'
...
```

```bash
./bin/bundle
```



## add two models
```bash
./bin/rails g model Surfer name
```
```bash
    # >>> Result
    Running via Spring preloader in process 57146
        invoke  active_record
        create    db/migrate/20210122213057_create_surfers.rb
        create    app/models/surfer.rb
        invoke    test_unit
        create      test/models/surfer_test.rb
        create      test/fixtures/surfers.yml
```
```bash
./bin/rails g model Board name size:integer surfer:belongs_to
```
```bash
    # >>> Result
    Running via Spring preloader in process 57189
        invoke  active_record
        create    db/migrate/20210122213109_create_boards.rb
        create    app/models/board.rb
        invoke    test_unit
        create      test/models/board_test.rb
        create      test/fixtures/boards.yml
```

```bash
nano ./app/models/surfer.rb
```
```bash
# FILE (app/models/surfer.rb)
class Surfer < ApplicationRecord
    has_many :boards
end
```
```bash
nano ./app/models/board.rb
```
```bash
# FILE (app/models/surfer.rb)
class Board < ApplicationRecord
  belongs_to :surfer
  enum size: [:small, :medium, :large]
end
```



## create a new dtabase and schema
```bash
./bin/rails db:migrate
```
```bash
./bin/rails dbconsole
```
```bash
    # >>> Result
    SQLite version 3.31.1 2020-01-27 19:55:54
    Enter ".help" for usage hints.
    sqlite> .tables
    ar_internal_metadata  schema_migrations   
    boards                surfers             
    sqlite> select * from boards;
    sqlite> .q
```



## add new seed data
```bash
nano ./db/seeds.rb
```
```bash
# FILE ()
Surfer.create(name: "Matt")
Surfer.create(name: "Eric")
Board.create(name: "Matt", size: 2, surfer_id: 1)
Board.create(name: "Matt", size: 1, surfer_id: 2)
```
```bash
./bin/rails db:seed
```
```bash
    # >>> Result:nothing
```
```bash
./bin/rails dbconsole
```
```bash
    # >>> Result
    SQLite version 3.31.1 2020-01-27 19:55:54
    Enter ".help" for usage hints.
    sqlite> select * from boards;
    1|Matt|2|1|2021-01-22 21:41:01.805216|2021-01-22 21:41:01.805216
    2|Matt|1|2|2021-01-22 21:41:01.910360|2021-01-22 21:41:01.910360
    sqlite> .q
```




## add a new serializer class
```bash
./bin/rails g serializer Board
```
```bash
    # >>> Result
    Running via Spring preloader in process 62290
        create  app/serializers/board_serializer.rb
```
```bash
nano ./app/serializers/board_serializer.rb
```
```bash
# FILE (./app/serializers/board_serializer.rb)
class BoardSerializer < ActiveModel::Serializer
  attributes :id, :name, :size, :surfer_id
​
  def surfer_id
    self.object.surfer.name
  end
end
```

 
## get the app-back-end-html
```bash
git clone -b app-back-end-html https://github.com/cnruby/rails-demo-cors.git app-back-end-html && \
cd app-back-end-html
```



## references
- https://medium.com/@camfeg/step-by-step-guide-to-set-up-a-basic-full-stack-app-with-rails-and-vanilla-javascript-12ae33ff0c64
- 