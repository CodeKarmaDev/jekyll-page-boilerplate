A boilerplate is a markdown file in the `_boilerplates` folder.

ie. `_boilerplates/post.md`
    ---
    _boilerplate:     # boilerplate settings
        path: _posts    #   the path to create the new page under.
        timestap: true  #   when true new post/pages will include the date in the filename. 
    
    title: {{ boilerplate.title }}
    layout: post      # everthing else will be copied to the new post.
    author: John Doe

`$ boilerplate post -T "Another one about pottery"` would create a new file `_posts/yyyy-mm-dd-another-one-about-pottery.markdown`
    ---
    title: Another one about pottery
    created: 'yyyy-mm-dd hh:mm:ss -0000'
    layout: post
    author: John Doe
    ---

Available Tags with `{{ boilerplate.xxx }}`:
- `.title`, `.name`
- `.path`, `.file`, `.suffix`
- `.time`, `.date`, `.timestamp`
- `.random_url`
- And anything you put under the `_boilerplate:` header



Use `boilerplate help` for more details
