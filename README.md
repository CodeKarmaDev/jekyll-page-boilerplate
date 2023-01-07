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
_boilerplate:           # The config for your boilerplates:
  path: _posts          # this is the folder path it will create your new post/page under. 
  timestamp: true       # when true new post/pages will include the date in the filename.
  title: Default Title  # You can provide a title here or with the -t option

title: {{ boilerplate.title }}   # -t or --title options
created: {{ boilerplate.time }}  # the current time.

layout: post      # Anything else in the file will be copied to your new post/page.
author: John Doe
---

A Jekyll Boilerplate Example

```

Run `$ boilerplate BOILERPLATE_NAME 'MY POST TITLE'`

ie `$ boilerplate post 'Another one about pottery'`


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

### Templating

The boilerplate will replace `{{ boilerplate.xxx }}` its own data.

- `title` as provided by the `-t` option or as provided in the `_boilerplate` header.
- `name` the name of the boilerplate (`_boilerplates/posts.md > posts`)
- `suffix` the file suffix (`.md`, `.markdown`, `.txt`)
- `time` the datetime the post was created at.
- `date` the date as used in the file timestamp
- `file` the filename of the new post
- `path` the folder to place the new file in. provided with the `-p` option or in the header.
- `timestamp` should it include a timestamp in the file name.
- `random` a random url safe base 64 string 

you can also provide your own data in the `_boilerplate` header and use it in your document.

## Boilerplate Header

In the header `file, path, slug` will all accept wild cards
```yaml
_boilerplate:
  file: '{{ chapter }}{{ slug }}{{ suffix }}'
  path: '_chapters/{{ volume }}'
  slug: '{{ title }}'
  volume: 1
  # Default ^^ replace with `bplate <page> volume=54`
  # the timestamp flag will override the file template.
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
