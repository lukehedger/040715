var gulp = require('gulp'),
	browserify = require('browserify'),
	source = require('vinyl-source-stream'),
	sourcemaps = require('gulp-sourcemaps'),
	uglify = require('gulp-uglify'),
	stylus = require('gulp-stylus'),
	rupture = require('rupture'),
	jeet = require('jeet'),
	minifycss = require('gulp-minify-css'),
	gutil = require('gulp-util'),
	browserSync = require('browser-sync'),
	psi = require('psi');

// config
var config = {
	paths: {
		coffee: './coffee/app.coffee',
		js: './js',
		stylus: './stylus/**/*.styl',
		css: './stylus/main.styl',
		template: './template/**/*.html',
		release: './public',
		releaseCopy: [
		'error.html',
		'index.html',
		'humans.txt',
		'robots.txt'
		]
	},
	site: 'http://*.divshot.io/'
};

// browserify
gulp.task('browserify', function () {
	browserify({
		entries: [config.paths.coffee],
		extensions: ['.coffee'],
		debug: true
	})
	.bundle()
	.on('error', gutil.log)
	.pipe(source('bundle.js'))
	.pipe(gulp.dest(config.paths.js))
	.pipe(browserSync.reload({stream:true, once: true}))
});

// script release
gulp.task('script-release', function () {
	gulp.src('./js/bundle.js')
	.pipe(uglify())
	.pipe(gulp.dest('./public/js'));
});

// style
gulp.task('style', function () {
	gulp.src(config.paths.css)
	.pipe(stylus({
		use: [rupture(), jeet()],
		compress: false
	}))
	.pipe(gulp.dest('css'))
	.pipe(browserSync.reload({stream:true}));
});

// style release
gulp.task('style-release', function () {
	gulp.src('./css/main.css')
	.pipe(minifycss({
		keepBreaks: false
	}))
	.pipe(gulp.dest('./public/css'));
});

// server
gulp.task('server', function() {
    browserSync.init(null, {
        server: {
            baseDir: "./"
        },
        ports: {
        	min: 5000,
        	max: 5000
        },
        open: true,
        notify: false
    });
});

// PageSpeed Insights
gulp.task('pagespeed.mobile', function (cb) {
	psi({
	    // key: config.key
	    nokey: 'true',
	    url: config.site,
	    strategy: 'mobile',
	}, cb);
});
gulp.task('pagespeed.desktop', function (cb) {
	psi({
	    nokey: 'true',
	    url: config.site,
	    strategy: 'desktop',
	}, cb);
});

// copy release
gulp.task('copy-release', function () {
	gulp.src(config.paths.releaseCopy)
	.pipe(gulp.dest(config.paths.release));
});

// bundled tasks
gulp.task('default', function () {
	gulp.start('browserify', 'style', 'server', 'watch');
});

gulp.task('watch', function() {
	gulp.watch(config.paths.stylus, ['style']);
	gulp.watch([config.paths.coffee, config.paths.template], ['browserify']);
});

gulp.task('analyse', ['pagespeed.desktop', 'pagespeed.mobile']);

gulp.task('release', function () {
	gulp.start('script-release', 'style-release', 'copy-release');
});
