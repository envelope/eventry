module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-shell'

  grunt.initConfig
    clean: lib: ['lib']

    coffee:
      glob_to_multiple:
        expand: true
        cwd: 'src'
        src: ['*.coffee']
        dest: 'lib'
        ext: '.js'

    coffeelint:
      src: ['src/*.coffee']
      test: ['spec/*.coffee']
      gruntfile: ['Gruntfile.coffee']

    shell:
      test:
        command: 'node node_modules/jasmine-node/bin/jasmine-node --coffee spec'
        options:
          stdout: true
          stderr: true
          failOnError: true

  grunt.registerTask 'lint', ['coffeelint']
  grunt.registerTask 'default', ['coffee']
  grunt.registerTask 'test', ['lint', 'shell:test']
