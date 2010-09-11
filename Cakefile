fs = require 'fs'

dir = "build"

task 'build:html', 'compile the jade template files to html', () ->
  jade = require 'jade'
  jade.renderFile 'jade/index.jade', (err, html) ->
    if err
      console.log err
    else
      fs.mkdir "$dir", 0755,() ->
        fs.writeFile "$dir/index.html", html

