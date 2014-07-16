# 040715

## Stack

- **CoffeeScript** - language that compiles to JavaScript [http://coffeescript.org/](http://coffeescript.org/)
- **Myth** - CSS preprocessor [http://www.myth.io/](http://www.myth.io/)
- **GulpJS** - JavaScript task runner [http://gulpjs.com/](http://gulpjs.com/)
- **RequireJS** - JavaScript file and module loader [http://requirejs.org/](http://requirejs.org/)
- **Divshot** - Static site hosting [http://www.divshot.com/](http://www.divshot.com/)

## Setup

+ Install Gulp: `npm install -g gulp`
+ Install Gulp Dependencies: `npm install --save-dev`
+ Install Divshot CLI: `npm install -g divshot-cli`
+ 

## Local dev

+ Compile, watch and serve: `gulp`
+ Stop server/watching: `ctrl + c`

## Deployment

+ Push to Divshot: `divshot push <env>`
+ Promote to environment: `divshot promote <from_env> <to_env>`

## Status

[![Build Status](https://travis-ci.org/lukehedger/040715.svg?branch=master)](https://travis-ci.org/lukehedger/040715)