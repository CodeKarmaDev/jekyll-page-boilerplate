---
    
_boilerplate:
  path: test
  timestamp: false
  title: title
  type: testing
  num: 130 
     
layout: post
author: John Doe
title: {{ boilerplate.title }}
created: {{ boilerplate.time }}
random_url: {{ boilerplate.random }}
random_url: {{ boilerplate.random=5 }}
custom: {{ boilerplate.custom }}
num: {{ boilerplate.num }}
---


Default Test Heading
--------------------

some boilerplate text

Type is {{ boilerplate.type }}
File is {{ boilerplate.file }}

