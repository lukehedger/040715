# 040715

## Stack

- **[Angular-Firebase](https://www.firebase.com/docs/web/libraries/angular/quickstart.html)**
- **[CoffeeScript](http://coffeescript.org/)**
- **[Stylus](http://learnboost.github.io/stylus/)** (with [Jeet](http://jeet.gs/) & [Rupture](https://github.com/jenius/rupture))
- **[Gulp](http://gulpjs.com/)**
- **[Browserify](http://browserify.org/)**
- **[Divshot](http://www.divshot.com/)**
- **[Travis](https://travis-ci.org)**

## Setup

+ Install Divshot CLI: `npm install -g divshot-cli`
+ Install Gulp: `npm install -g gulp`
+ Install dependencies: `npm install && bower install`

## Local dev

+ Compile, watch and serve: `gulp`
+ Stop server/watching: `ctrl + c`

## Deployment

+ Run `gulp release` to build  your `public/` folder.
+ Just push to GitHub and Travis will deploy to the development environment
+ Push to Divshot manually: `divshot push <env>`
+ Promote to environment: `divshot promote <from_env> <to_env>`

## Status

[![Build Status](http://img.shields.io/travis/lukehedger/040715/master.svg?style=flat)](https://travis-ci.org/lukehedger/040715)
