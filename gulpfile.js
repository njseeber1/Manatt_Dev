'use strict';
/*****************************************
    Variables
******************************************/
//Dependency Variables
var autoprefixer = require('gulp-autoprefixer'),
  base64 = require('gulp-css-base64'),
  bs = require('browser-sync').create(),
  //concat = require('gulp-concat'),
  //del = require('del'),
  //filter = require('gulp-filter'),
  gulp = require('gulp'),
  pug = require('gulp-pug'),
  //minify = require('gulp-minify'),
  notify = require('gulp-notify'),
  plumber = require('gulp-plumber'),
  //replace = require('gulp-replace'),
  //runSequence = require('run-sequence'),
  sass = require('gulp-sass'),
  sourcemaps = require('gulp-sourcemaps'),
  reload = bs.reload;
//Browsersync Variables
//var siteProxy = "iappspro.design.local.iapps.com";
//var sitePort = Math.floor(Math.random() * (49150 - 1024 + 1)) + 1024;
//var uiPort = sitePort + 1;


/*****************************************
    SCSS/CSS Tasks
******************************************/
//Delete old compiled CSS
//gulp.task('cleanCSS', function() {
//                return del('Style Library/css/**');
//});
//Compile SCSS, Prefix, Write Sourcemap
gulp.task('compileCSS', function() {
  return gulp.src(['style/scss/**/*.scss'])
    .pipe(plumber({ errorHandler: notify.onError('<%= error.message %>') }))
    .pipe(sourcemaps.init())
    .pipe(sass({ outputStyle: 'compressed' }).on('error', function(err) {
      new Error(err);
    }))
    .pipe(autoprefixer({
      browsers: ['last 2 versions'],
      cascade: false
    }))
    .pipe(sourcemaps.write('./'))
    .pipe(plumber.stop())
    .pipe(gulp.dest('style/css'))
    .pipe(bs.stream({ match: '**/*.css' }));
});

/*****************************************
    PUG Tasks
******************************************/
//Delete old compiled CSS
//gulp.task('cleanCSS', function() {
//                return del('Style Library/css/**');
//});
//Compile SCSS, Prefix, Write Sourcemap
gulp.task('compilePUG', function() {
  return gulp.src(['pug/**/*.pug'])
    .pipe(plumber({ errorHandler: notify.onError('<%= error.message %>') }))
    .pipe(pug({
      // Your options in here.
      pretty: true,
      notify: false
    }))
    .pipe(gulp.dest('./')) // tell gulp our output folder
    // .pipe(bs.stream({
    //   once: true
    // }));
});
/**
 * Important!!
 * Separate task for the reaction to `.pug` files to call reload only after all pug files have
 * been compiled
 */
gulp.task('pugWatch', ['compilePUG'], function() {
	return gulp.src(['pug/**/*.pug'])
	    .pipe(bs.stream({
	      once: true
	    }));
});	

/*****************************************
    BrowserSync & Watch Tasks
******************************************/
//Browsersync watch and serve changes
gulp.task('serve', ['compileCSS', 'compilePUG'], function() {
  bs.init({
    notify: false,
    server: {
      baseDir: './'
    },
  })
  gulp.watch('style/**/*.scss', ['compileCSS']);
  gulp.watch('pug/**/*.pug', ['pugWatch']);
  //gulp.watch('pug/**/*.pug').on('change', browserSync.reload);
});
//Default gulp task start watching
gulp.task('default', ['serve']);
