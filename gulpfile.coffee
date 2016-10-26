gulp = require 'gulp'
coffee = require 'gulp-coffee'
folders = require 'gulp-folders'
concat = require 'gulp-concat'
path = require 'path'
browserify = require 'gulp-browserify'
runSequence = require 'gulp-run-sequence'
uglify = require 'gulp-uglifyjs'
del = require 'del'
rename = require 'gulp-rename'

gulp.task 'coffee-folders', ['clean'],  folders "src", (folder) ->
  gulp.src path.join "src", folder, "*.coffee"
      .pipe coffee bare: true
      .pipe gulp.dest "lib/" + folder

gulp.task 'coffee-inner', ['coffee-folders'], ->
  gulp.src path.join "src", "*.coffee"
      .pipe coffee bare: true
      .pipe gulp.dest "lib/"

gulp.task 'coffee', ['coffee-inner']

gulp.task 'browserify', ['coffee'], ->
  gulp.src 'lib/Yaml.js'
    .pipe browserify()
    .pipe rename 'yaml.js'
    .pipe gulp.dest 'dist-new'

gulp.task 'uglify', ['browserify'], ->
  gulp.src 'dist-new/yaml.js'
    .pipe uglify 'yaml.min.js'
    .pipe gulp.dest 'dist-new/'

gulp.task 'clean', ->
  del 'lib/**/*'
  del 'dist-new/**/*'

gulp.task 'default', runSequence('clean', 'uglify')
