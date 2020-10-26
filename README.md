# JekyllPageBoilerplate

A jekyll plugin that allows you to create new pages or posts from a boilerplate.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jekyll-page-boilerplate'
```

And then execute `$ bundle install`

Or `$ gem install jekyll-page-boilerplate`

Run `$ boilerplate init` to create an example file.

## Usage


Create a new jekyll page/post from a boilerplate.

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
```

Run `$ boilerplate page post 'Another one about pottery'`

This will create a new file under `_posts/yyyy-mm-dd-another-one-about-pottery.markdown`
```yml
---
title: Another one about pottery
created: 'yyyy-mm-dd hh:mm:ss -0000'
layout: post
author: John Doe
---

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
