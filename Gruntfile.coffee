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
        src: ['src/*.coffee']
        dest: 'lib/'
        ext: '.js'
      tests:
        options:
          sourceMap: false
        expand: true
        flatten: true
        src: ['src-test/*.coffee']
        dest: 'test/'
        ext: '.js'

    coffeelint:
      app: ['src/*.coffee']
      tests:
        files:
          src: ['tests/*.coffee']

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

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-nodeunit')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-coffee')

  # Default task.
  grunt.registerTask('default', ['coffeelint', 'coffee:app', 'coffee:tests', 'nodeunit'])
