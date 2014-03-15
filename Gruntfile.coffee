module.exports = (grunt) ->

  grunt.initConfig

    files:
      js: 
        vendor: [
          'bower_modules/underscore/underscore.js'
          'bower_modules/jquery/dist/jquery.js'
          'bower_modules/platform/platform.js'
          'bower_modules/d3/d3.js'
          'bower_modules/d3-cloud/d3.layout.cloud.js'
          'bower_modules/firebase/firebase.js'
        ]
        src: [
          "js/**/*.js"
        ]

      sass:
        src: ['app/styles/main.css.scss']

      coffee: 
        dest: 'generated/compiled-coffee'
        compiled: 'generated/compiled-coffee/**/*.js'

      data: 
        src: ['app/data/*.{json,yml}']

      html:
        src: ['app/docs/*.{hbs,md}']

      layouts:
        src: ['app/layouts/polymer.hbs']

      webcomponents:
        src: ['app/elements/**/*.html']

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
        cwd: 'app/coffee'
        src: '**/*.coffee'
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

    sass:
      dev:
        dest: 'generated/styles/main.css'
        src: '<%= files.sass.src %>'

    copy:
      customComponents: 
        expand: true
        flatten: true
        cwd: 'app/elements/'
        dest: 'generated/elements/'
        src: ['**']

      polymerComponents: 
        expand: true
        flatten: true
        cwd: 'bower_modules/polymer'
        dest: 'generated/elements/library'
        src: ['**']

    watch:
      options:
        livereload: true

      coffee:
        files: 'app/coffee/**/*.coffee'
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

      webcomponents:
        files: 'app/elements/**/*.html'
        tasks: ['copy']

  grunt.loadTasks "tasks"

  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-sass"
  grunt.loadNpmTasks 'assemble'

  grunt.registerTask "default", ["assemble", "copy", "sass", "coffee", "concat", "watch"]
  grunt.registerTask "heroku", ["assemble", "coffee", "concat"]
