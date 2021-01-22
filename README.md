<h1>Hello Rails + CORS for HTML</h1>
- Cross Origin Resource Sharing = CORS
- allow our api to send back data in json format that we can then use in our html front-end.

---

<h2>Table of Contents</h2>

- [create a new app-back-end-api](#create-a-new-app-back-end-api)
- [add a new serializer class](#add-a-new-serializer-class)
- [get the project `app-back-end-html`](#get-the-project-app-back-end-html)
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

```bash
./bin/rails db:migrate RAILS_ENV=development
```

```bash
./bin/rails db:seed RAILS_ENV=development
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

 
## get the project `app-back-end-html`
```bash
git clone -b app-back-end-html https://github.com/cnruby/rails-demo-cors.git app-back-end-html && \
cd app-back-end-html
```



## references
- https://medium.com/@camfeg/step-by-step-guide-to-set-up-a-basic-full-stack-app-with-rails-and-vanilla-javascript-12ae33ff0c64
- 