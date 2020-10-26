
module JekyllPageBoilerplate
  module Msg

    HELP = <<-'HELP'
      Usage:
        `jekyll-page BOILERPLATE_FILE_NAME "MY PAGE TITLE"`
      
      Create a new jekyll page/post from a boilerplate.

      A boilerplate is a yaml file in the `_boilerplates` folder.

      Boilerplate yaml settings:
        path - the path to create the new page under.
        timestamp - when true new post/pages will include the date in the filename.
        header - Any yaml you put under `header` will be included in new pages/post all the yaml
        
      Example: 
        _boilerplates/post.yml
          ---
          path: _posts
          timestap: true
          
          header:
            layout: post
            auther: John Doe

        $ jekyll-page pots "Another one about pottery"
        
        _posts/yyyy-mm-dd-another-one-about-pottery.markdown
          ---
          title: Another one about pottery
          created: 'yyyy-mm-dd hh:mm:ss -0000'
          layout: post
          auther: John Doe
          ---
        

    HELP
  
  end
end