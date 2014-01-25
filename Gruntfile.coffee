module.exports = (grunt) ->
  
  # Project configuration.
  grunt.initConfig

    shell:
      'compile-server-side':
        options: stdout: true, stderr: true
        command: 'coffee -o ./ -c src/'
      'compile-client-side':
        options: stdout: true, stderr: true
        command: 'coffee -o public/scripts/compiled/ -c public/scripts/src/'
      'compile-css':
        options: stdout: true, stderr: true
        command: 'stylus public/styles/'
      'compile-jade':
        options: stdout: true, stderr: true
        command: 'node_modules/clientjade/bin/clientjade public/scripts/src/views/*.jade > public/scripts/compiled/jade.js'
      'dev-out':
        options: stdout: true, stderr: true
        command: 'cp public/scripts/out.js public/scripts/out.min.js'
      static:
        options: stdout: true, stderr: true
        command: 'mkdir -p static && curl http://localhost:5001 >> static/index.html'
      sprite:
        options: stdout: true, stderr: true
        command: 'glue public/images/sprites --crop --img=public/images --css=public/styles --sprite-namespace= ' + 
          """--global-template=".sprite{display:inline-block;background-image:url('%(sprite_url)s');background-repeat:no-repeat}\n" """

    concat:
      js:
        options:
          separator: ';'
        src: ['public/scripts/compiled/**/*.js']
        dest: 'public/scripts/out.js'
      css:
        src: 'public/styles/**/*.css'
        dest: 'public/styles/out.css'

    uglify:
      build:
        src: 'public/scripts/out.js'
        dest: 'public/scripts/out.min.js'

    clean:
      js: ['*.js', 'public/scripts/compiled/', 'public/scripts/*.js']
      css: 'public/styles/*.css'
      components: 'public/components'
      npm: 'node_modules'
      static: 'static'
      sprite: ['public/images/sprites.png', 'public/styles/sprites.css']

    watch:
      coffeeClient:
        files: ['public/scripts/src/**/*.coffee']
        tasks: ['shell:compile-client-side', 'concat', 'shell:dev-out']
      coffeeServer:
        files: ['src/*.coffee']
        tasks: ['shell:compile-server-side', 'concat', 'shell:dev-out']
      clientJade:
        files: ['public/**/*.jade']
        tasks: ['shell:compile-jade', 'concat', 'shell:dev-out']

  
  # Plugins
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  # Tasks
  grunt.registerTask 'static', ['shell:static']
  grunt.registerTask 'sprite', ['shell:sprite']
  grunt.registerTask 'compile', ['shell:compile-server-side', 'shell:compile-client-side', 'shell:compile-css', 'shell:compile-jade']
  grunt.registerTask 'dev', ['compile', 'concat', 'shell:dev-out']
  grunt.registerTask 'default', ['compile', 'sprite', 'concat', 'uglify']
