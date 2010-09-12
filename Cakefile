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
  input: fs.createReadStream 'sass/style.sass'
  buffer: ""
  input.addListener "data", (data) ->
    buffer += data
  input.addListener "end", (data) ->
    buildpath: 'build/css/style.css'
    write: ->
      output: fs.createWriteStream buildpath
      output.write sass.render buffer
    if not path.exists path.dirname buildpath
      fs.mkdir path.dirname(buildpath), 0755, write
    else
      write()

task 'build:includes', 'symlink the includes files the build folder', () ->
  fs.stat 'includes', (err, stats) ->
    if stats.isDirectory()
      fs.readdir 'includes', (err, files) ->
        for file in files
          file: path.join 'includes',file
          fs.stat file, (err, stats) ->
            if stats.isDirectory()
              f: path.basename file
              output: "$dir/$f"
              path.exists output, (exists) ->
                linkFiles: () ->
                  fs.readdir file, (err, files) ->
                      for link in files
                        orig: path.join process.cwd(), file, link
                        linkdata: path.join output, link
                        fs.symlink orig, linkdata, (err) ->
                          if err?
                            sys.puts orig, linkdata
                            sys.puts err
                if not exists
                  fs.mkdir output, 0755, linkFiles
                else
                  linkFiles()

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
