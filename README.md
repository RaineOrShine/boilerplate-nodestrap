Scaffolding for a coffee-fueled web stack.
**node + bower + bootstrap + backbone + creatable**

    npm install && bower install && grunt
    supervisor app.js

*port specified in src/config.coffee*

View available grunt tasks:

    grunt --help

# What's Included
### server-side (npm)

* express
* mongodb
* underscore
* rjs
* jade
* async

### client-side (bower)

* bootstrap
* underscore
* backbone
* rjs
* creatable

### global dependencies

* node
* npm
* grunt-cli
* bower
* coffee
* stylus
* mongod

# directory structure

    root
      |- public
        |- components
        |- images
        |- styles
        |- scripts
           |- compiled
           |- src
      |- src
        |- models
      |- view
