
module JekyllPageBoilerplate
  module Msg

    HELP = <<-'HELP'

      Create a new jekyll page/post from a boilerplate.

      A boilerplate is a yaml file in the `_boilerplates` folder.

      ie. `_boilerplates/post.yml`
          ---
          path: _posts
          timestap: true
          
          header:
            layout: post
            author: John Doe
      
      Boilerplate yaml settings:
        path - the path to create the new page under.
        timestamp - when true new post/pages will include the date in the filename.
        header - Any yaml you put under `header` will be added to your new pages/post
        

      `$ boilerplate page post "Another one about pottery"`
      
      would create a new file `_posts/yyyy-mm-dd-another-one-about-pottery.markdown`
        ---
        title: Another one about pottery
        created: 'yyyy-mm-dd hh:mm:ss -0000'
        layout: post
        author: John Doe
        ---
        

    HELP
  
  end
end