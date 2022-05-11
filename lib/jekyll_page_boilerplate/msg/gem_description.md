A boilerplate is a markdown file you place under the `_boilerplates/<boilerplate>.md` folder to generate new pages for jekyll.


It can automatically timestamp and title new pages.


It will also replacing any `{{ boilerplate.xxx }}` tags with content. Available tags include `.time, .title, .date, .random_url`.


You can also provide custom tags with `boilerplate post nav_order=1` > `{{ boilerplate.nav_order }}`.


In the boilerplate header you can specify options like the path to generate pages under and if filenames should be timestamped. `_boilerplate: > path: '_posts/'`


