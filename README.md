<h1>Hello Rails + CORS for API</h1>
- Cross Origin Resource Sharing = CORS

---

<h2>Table of Contents</h2>

- [create a new app-back-end-api](#create-a-new-app-back-end-api)
- [add two models](#add-two-models)
- [create a new database and schema](#create-a-new-database-and-schema)
- [add new seed data](#add-new-seed-data)
- [add two controllers](#add-two-controllers)
- [run the app api](#run-the-app-api)
- [get the app-back-end-api](#get-the-app-back-end-api)
- [references](#references)


---

## create a new app-back-end-api
```bash
rails new app-back-end-api --api && \
cd app-back-end-api
```

```bash
nano ./Gemfile.rb
```
```bash
# FILE (./Gemfile.rb)
...
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
...
```

```bash
./bin/bundle
```

```bash
nano ./config/initializers/cors.rb
```
```bash
# FILE (./config/initializers/cors.rb)
Rails.application.config.middleware.insert_before 0, Rack::Cors, debug: true, logger: (-> { Rails.logger }) do
    allow do
      origins '*'
    #   origins 'localhost'
  
      resource '*',
        :headers => :any,
        :methods => [:get, :post, :delete, :put, :patch, :options, :head],
        :max_age => 0
    end
end
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



## create a new database and schema
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




## add two controllers
```bash
rails g controller boards index --skip-template-engine
```
```bash
    # >>> Result
    Running via Spring preloader in process 58216
        create  app/controllers/boards_controller.rb
        route  get 'boards/index'
        invoke  test_unit
        create    test/controllers/boards_controller_test.rb
```
```bash
nano ./app/controllers/boards_controller.rb
```
```bash
# FILE (./app/controllers/boards_controller.rb)
class BoardsController < ApplicationController
  def index
    @boards = Board.all
    render json: @boards
  end
end
```

```bash
rails g controller surfer index --skip-template-engine
```
```bash
    # >>> Result
    Running via Spring preloader in process 58306
        create  app/controllers/surfer_controller.rb
        route  get 'surfer/index'
        invoke  test_unit
        create    test/controllers/surfer_controller_test.rb
```
```bash
nano ./app/controllers/surfers_controller.rb
```
```bash
# FILE (./app/controllers/surfers_controller.rb)
class SurfersController < ApplicationController
  def index
    @surfers = Surfer.all
    render json: @surfers
  end
end
```



## run the app api
```bash
./bin/rails server
```
```bash
curl --no-progress-meter http://127.0.0.1:3000/boards/index | json_pp
```
```bash
    # >>> Result
    [
        {
            "created_at" : "2021-01-22T21:41:01.805Z",
            "id" : 1,
            "name" : "Matt",
            "size" : "large",
            "surfer_id" : 1,
            "updated_at" : "2021-01-22T21:41:01.805Z"
        },
        {
            "created_at" : "2021-01-22T21:41:01.910Z",
            "id" : 2,
            "name" : "Matt",
            "size" : "medium",
            "surfer_id" : 2,
            "updated_at" : "2021-01-22T21:41:01.910Z"
        }
    ]
```
```bash
curl --no-progress-meter http://127.0.0.1:3000/surfers/index | json_pp
```
```bash
    # >>> Result
    [
        {
            "created_at" : "2021-01-22T21:41:01.566Z",
            "id" : 1,
            "name" : "Matt",
            "updated_at" : "2021-01-22T21:41:01.566Z"
        },
        {
            "created_at" : "2021-01-22T21:41:01.669Z",
            "id" : 2,
            "name" : "Eric",
            "updated_at" : "2021-01-22T21:41:01.669Z"
        }
    ]
```



## get the app-back-end-api
```bash
git clone -b app-back-end-api https://github.com/cnruby/rails-demo-cors.git app-back-end-api && \
cd app-back-end-api
```



## references
- https://medium.com/@camfeg/step-by-step-guide-to-set-up-a-basic-full-stack-app-with-rails-and-vanilla-javascript-12ae33ff0c64
- 