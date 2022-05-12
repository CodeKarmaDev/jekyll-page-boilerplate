A boilerplate is a markdown file you place under the `_boilerplates` folder to generate new pages for jekyll.

`_boilerplates/post.md`

    ---
    _boilerplate:       # boilerplate settings
        path: _posts    # the path to create the new page under.
        timestamp: true  # when true new post/pages will include the date in the filename.
        # a custom slug overrides the timestamp setting
        slug: '{{ title }}-{{ date }}{{ suffix }}' 
        # slug is a template for the filename, it cant take the same tags everything else.
    title: {{ boilerplate.title }} # tags like this will be replaced
    layout: post        # everthing else will be copied to the new post.
    author: John Doe


`$ boilerplate post -T "Another one about pottery"` would create a new file `_posts/yyyy-mm-dd-another-one-about-pottery.markdown`

    ---
    title: Another one about pottery
    created: 'yyyy-mm-dd hh:mm:ss -0000'
    layout: post
    author: John Doe


Available Tags `{{ boilerplate.xxx }}`:
- `.title`, `.name`
- `.path`, `.file`, `.suffix`
- `.time`, `.date`, `.timestamp`
- `.random_url`
- Custom tags you provide in the command `bplate post custom=1`
- And anything you put under the `_boilerplate:` header
