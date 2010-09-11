fs = require 'fs'
sys = require 'sys'

dir = "build"

task 'build:html', 'compile the jade template files to html', () ->
  jade = require 'jade'
  jade.renderFile 'jade/index.jade', (err, html) ->
    if err
      console.log err
    else
      fs.mkdir "$dir", 0755,() ->
        fs.writeFile "$dir/index.html", html

task 'build:js', 'compile the coffeescript files to js', () ->
  compile: require("child_process").spawn "coffee", ["-c", "-o", "$dir/js", "coffee/seinfeld.coffee"]
  compile.stdout.addListener "data", (data) ->
    sys.puts data
  compile.stderr.addListener "data", (data) ->
    sys.puts data
  compile.addListener "exit", (code) ->
    sys.puts "Coffe compile exited with exit code $code."
