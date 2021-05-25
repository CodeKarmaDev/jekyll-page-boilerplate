# JekyllPageBoilerplate

A jekyll plugin that allows you to create new pages or posts from a boilerplate.

[jekyll-compose](https://github.com/jekyll/jekyll-compose) might be the gem you are looking for.

## Installation


```ruby
gem 'jekyll-page-boilerplate'
```

```
$ bundle install
```

Or 
```
$ gem install jekyll-page-boilerplate
```


## Usage


Create a new jekyll page/post from a boilerplate.

Run `$ boilerplate init` to create an example file.

Create a new boilerplate file under the `_boilerplates` folder.

ie. `_boilerplates/post.md`
```yaml
---
_boilerplate:     # The config for your boilerplates:
  path: _posts    # this is the folder path it will create your new post/page under. 
  timestamp: true # when true new post/pages will include the date in the filename.

title: TITLE      # The title will be overwriten
created: CREATED  # created will be overwriten with the current time

layout: post      # Anything else in the file will be copied to your new post/page.
author: John Doe
---

A Jekyll Boilerplate Example

```

Run `$ boilerplate page BOILERPLATE_NAME 'MY POST TITLE'`

ie `$ boilerplate page post 'Another one about pottery'`


This will create a new file under `_posts/yyyy-mm-dd-another-one-about-pottery.markdown`
```
---
title: Another one about pottery
created: 'yyyy-mm-dd hh:mm:ss -0000'
layout: post
author: John Doe
---

A Jekyll Boilerplate Example
```


## Development

To install your development version of the gem, 
clone the repo and add this to your `Gemfile`.
```
gem 'jekyll-page-boilerplate', :path => "path/to/repo/jekyll-page-boilerplate"
```

Use `$ rake spec` to run the tests.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
