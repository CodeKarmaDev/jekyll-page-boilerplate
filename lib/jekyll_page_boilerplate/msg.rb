
module JekyllPageBoilerplate
  module Msg

    HELP = <<-'HELP'

  A boilerplate is a markdown file in the `_boilerplates` folder.

  ie. `_boilerplates/post.yml`
      ---
      _boilerplate:     # boilerplate settings
        path: _posts    #   the path to create the new page under.
        timestap: true  #   when true new post/pages will include the date in the filename. 
      
      layout: post      # everthing else will be copied to the new post.
      author: John Doe
  

  `$ boilerplate page post "Another one about pottery"` would create a new file `_posts/yyyy-mm-dd-another-one-about-pottery.markdown`
      ---
      title: Another one about pottery
      created: 'yyyy-mm-dd hh:mm:ss -0000'
      layout: post
      author: John Doe
      ---


  Usage: `$ boilerplate [page|init|help]`

  `$ boilerplate init`: creates a example boilerplate at `_boilerplates/example.md`
  
  `$ boilerplate page <boilerplate-name> <post-title>`: Creates a new page from a boilerplate

  `$ boilerplate help`: shows this dialog.

    HELP
  
  end
end