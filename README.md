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

ie. `_boilerplates/post.yml`
```yaml
# the path to create the new page under.
path: _posts

# when true new post/pages will include the date in the filename.
timestamp: true

# Any yaml you put under `header` will be added to your new pages/post
header:
  layout: post
  author: John D

# the markdown content to put in the new post
content: '

# Default Heading'

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

# Default Heading
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
