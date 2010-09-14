fs = require 'fs'
sys = require 'sys'
path = require 'path'

dir = "build"

task 'build:html', 'compile the jade template files to html', () ->
  jade = require 'jade'
  jade.renderFile 'jade/index.jade', (err, html) ->
    if err
      console.log err
    else
      fs.mkdir "$dir", 0755,() ->
        fs.writeFile "$dir/index.html", html

coffeeFiles = [
    "coffee/seinfeld.coffee",
]

task 'build:js', 'compile the coffeescript files to js', () ->
  compile: require("child_process").spawn "coffee", ["-c", "-o", "$dir/js"].concat coffeeFiles
  compile.stdout.addListener "data", (data) ->
    sys.puts data
  compile.stderr.addListener "data", (data) ->
    sys.puts data
  compile.addListener "exit", (code) ->
    sys.puts "Coffee compile exited with exit code $code." if code != 0

task 'build:css', 'compile the sass files to css', () ->
  sass: require 'sass'
  for f in ["style", "big"]

    input: fs.createReadStream "sass/${f}.sass"
    buffer: ""
    input.addListener "data", (data) ->
      buffer += data
    input.addListener "end", (data) ->
      buildpath: "build/css/${f}.css"
      write: ->
        output: fs.createWriteStream buildpath
        output.write sass.render buffer
      if not path.exists path.dirname buildpath
        fs.mkdir path.dirname(buildpath), 0755, write
      else
        write()

task 'build:includes', 'symlink the includes files the build folder', () ->
  cp: require("child_process").spawn "cp", ["-R", "includes/img", "includes/js", "$dir"]
  cp.stdout.addListener "data", (data) ->
    sys.puts data
  cp.stderr.addListener "data", (data) ->
    sys.puts data
  cp.addListener "exit", (code) ->
    sys.puts "cp exited with exit code $code." if code != 0


task 'build', 'build everything', () ->
    invoke 'build:html'
    invoke 'build:js'
    invoke 'build:css'
    invoke 'build:includes'

task 'clean', 'remove the build folder', () ->
  clean: require("child_process").spawn "rm", ["-rf", dir]
  clean.stdout.addListener "data", (data) ->
    sys.puts data
  clean.stderr.addListener "data", (data) ->
    sys.puts data
  clean.addListener "exit", (code) ->
    sys.puts "Removal of $dir error!" if code != 0
