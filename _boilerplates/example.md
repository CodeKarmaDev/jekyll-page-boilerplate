---
_boilerplate:     # The config for your boilerplates:
  path: _posts    # this is the folder path it will create your new post/page under. 
  timestamp: true # when true new post/pages will include the date in the filename.

title: {{ boilerplate.title }}   # -T or --title options
created: {{ boilerplate.time }}  # the current time.

layout: post      # Anything else in the file will be copied to your new post/page.
author: John Doe
---


A Jekyll Boilerplate Example
----------------------------


To create a new page/post from this boilerplate run:
```bash
$ boilerplate create example "Another post about pottery"`
```

A boilerplate is a markdown file in the `_boilerplates` folder.


This would create a new file:

```text 
_posts/yyyy-mm-dd-another-one-about-pottery.markdown
---
title: Another one about pottery
created: 'yyyy-mm-dd hh:mm:ss -0000'
layout: post
author: John Doe
---

A Jekyll Boilerplate Example
----------------------------

To create a new page/post from this boilerplate run:

recursion error...

```