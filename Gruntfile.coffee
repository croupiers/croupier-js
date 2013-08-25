'use strict'

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    nodeunit:
      files: ['test/**/*_test.js']

    coffee:
      app:
        options:
          sourceMap: true
        expand: true
        flatten: true
        src: ['src/**/*.coffee']
        dest: 'lib/'
        ext: '.js'
      bin:
        files:
          'bin/croupier-js': 'src-bin/croupier-js.coffee'
      tests:
        options:
          sourceMap: false
        expand: true
        flatten: true
        src: ['src-test/**/*.coffee']
        dest: 'test/'
        ext: '.js'

    coffeelint:
      app: ['src/*.coffee']
      tests:
        files:
          src: ['tests/*.coffee']

    exec:
      binShebang:
        command: "echo '\#\!/usr/bin/env node' > bin/croupier-js.new"
      addJsFile:
        command: "cat bin/croupier-js >> bin/croupier-js.new"
      moveBack:
        command: "mv bin/croupier-js{.new,}"
    watch:
      gruntfile:
        files: '<%= jshint.gruntfile.src %>'
        tasks: ['jshint:gruntfile']
      lib:
        files: '<%= jshint.lib.src %>'
        tasks: ['jshint:lib', 'nodeunit']
      test:
        files: '<%= jshint.test.src %>'
        tasks: ['jshint:test', 'nodeunit']

  grunt.registerTask "addSheBang", ['exec:binShebang', 'exec:addJsFile', 'exec:moveBack']

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-nodeunit')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-exec')

  # Default task.
  grunt.registerTask('default', ['coffeelint', 'coffee:app', 'coffee:bin', 'coffee:tests', "addSheBang", 'nodeunit'])
