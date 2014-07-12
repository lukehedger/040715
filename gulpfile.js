var gulp = require('gulp'),
	sourcemaps = require('gulp-sourcemaps'),
	coffee = require('gulp-coffee'),
	gutil = require('gulp-util'),
	myth = require('gulp-myth'),
	minifycss = require('gulp-minify-css'),
	browserSync = require('browser-sync');

gulp.task('coffee', function () {
	gulp.src('public/coffee/**/*.coffee')
		.pipe(sourcemaps.init())
		.pipe(coffee().on('error', gutil.log))
		.pipe(sourcemaps.write('./maps'))
		.pipe(gulp.dest('public/js'))
		.pipe(browserSync.reload({stream:true, once: true}));
});

gulp.task('myth', function () {
	gulp.src('public/myth/**/*.css')
		.pipe(myth())
		.pipe(gulp.dest('public/css'))
		.pipe(minifycss({
			keepBreaks: true,
			root: 'css',
			processImport: true
		}))
		.pipe(gulp.dest('public/css'))
		.pipe(browserSync.reload({stream:true}));
});

gulp.task('browser-sync', function() {
    browserSync.init(null, {
        server: {
            baseDir: "./public"
        },
        ports: {
        	min: 5000,
        	max: 5000
        },
        open: false, // disable automatic browser launch on server start
        notify: false // disable browser notifications
    });
});

gulp.task('default', function () {
	gulp.start('coffee', 'myth', 'browser-sync', 'watch');
});

gulp.task('watch', function() {
	gulp.watch('public/coffee/**/*.coffee', ['coffee']);
	gulp.watch('public/myth/**/*.css', ['myth']);
});