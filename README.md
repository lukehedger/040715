# 040715



## Stack

- **CoffeeScript** - language that compiles to JavaScript [http://coffeescript.org/](http://coffeescript.org/)
- **Myth** - CSS preprocessor [http://www.myth.io/](http://www.myth.io/)
- **GulpJS** - JavaScript task runner [http://gulpjs.com/](http://gulpjs.com/)
- **RequireJS** - JavaScript file and module loader [http://requirejs.org/](http://requirejs.org/)

## Structure


- **CoffeScript**
    - source CoffeeScript: edit `.coffee` files in `coffee/` and run `gulp watch` to compile and watch
- **JS**
    - compiled CoffeeScript



- **Myth**
    - source CSS: edit `.css` files in `myth/` and run `gulp watch` to compile and watch
    - includes responsive grid and other helpers in `myth/lib/`
- **CSS**
    - compiled Myth CSS


- **Vendor**
    - RequireJS
    - jQuery
    - add other vendor files here


## Getting started

To use Gulp to compile your project, run the following commands in the root of your project:

### Install Gulp

`npm install -g gulp`

### Install Gulp Dependencies

`npm install --save-dev`

### Compile and watch

`gulp watch`

### ...or just compile once

`gulp`

### Stop watching

`ctrl + c`
