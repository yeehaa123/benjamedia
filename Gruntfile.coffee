module.exports = (grunt) ->

  grunt.initConfig

    files:
      js: 
        vendor: [
          'bower_modules/underscore/underscore.js'
          'bower_modules/jquery/dist/jquery.js'
          'bower_modules/d3/d3.js'
          'bower_modules/d3-cloud/d3.layout.cloud.js'
        ]
        src: [
          "js/**/*.js"
        ]

      coffee: 
        dest: 'generated/compiled-coffee'
        compiled: 'generated/compiled-coffee/**/*.js'

      data: 
        src: ['app/data/*.{json,yml}']

      html:
        src: ['app/docs/*.{hbs,md}']

      layouts:
        src: ['app/layouts/default.hbs']

    concat:
      app:
        dest: 'generated/js/app.min.js'
        src: [
          '<%= files.js.vendor %>'
          '<%= files.coffee.compiled %>'
        ]

    coffee:
      compileClient:
        expand: true
        cwd: 'coffee'
        src: 'app/**/*.coffee'
        dest: '<%= files.coffee.dest %>'
        ext: '.js'

      compileServer:
        expand: true
        cwd: 'server'
        src: '**/*.coffee'
        dest: ''
        ext: '.js'

    assemble:
      options: 
        plugins: ['assemble-contrib-contextual']
        flatten: true
        layout: ['<%= files.layouts.src %>']
        data: '<%= files.data.src %>'
        contextual: 
          dest: 'tmp'
      pages:
        dest: 'generated'
        src: '<%= files.html.src %>'

    watch:
      options:
        livereload: true

      coffee:
        files: 'coffee/**/*.coffee'
        tasks: ['coffee', 'concat']

      js: 
        files: ['<%= files.js.vendor %>']
        tasks: ['concat']

      html:
        files: ['<%= files.html.src %>']
        tasks: ['assemble']

      layouts: 
        files: ['<%= files.layouts.src %>']
        tasks: ['assemble']

  grunt.loadTasks "tasks"

  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks 'assemble'

  grunt.registerTask "default", ["assemble", "coffee", "concat", "watch"]
  grunt.registerTask "heroku", ["assemble", "coffee", "concat"]
