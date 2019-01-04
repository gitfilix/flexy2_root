/**
 * Created by FLX on 21.05.2015.
 */
// reqired modules
var gulp = require('gulp');
var sass = require('gulp-sass');
var webserver = require('gulp-webserver');
var livereload = require('gulp-livereload');
var autoprefixer = require('gulp-autoprefixer');


// livereload default
livereload({ start: true });

//gulp task webserver needs folder app & perform livereload
gulp.task('webserver', function(){
    gulp.src('app')
        .pipe(webserver({
            // webserver options:
            // port 7777: for fun
            port:'777',
            //defaultFile: 'index7.html',
            // lifereload true
            livereload: true,
            directoryListing: false,
            fallback: 'index7.html',
            open:true
        })
    );
    console.log('html file written and re-loaded');
});


// gulp sass task1: style sass main-file function
gulp.task('sass', function(){
    // read all scss files
    gulp.src('app/scss/*.scss')
        // load sass
        .pipe(sass())
        // prevent gulp from crashing due to scss files
        .on('error', function (error){
            console.error("there was an base scss syntax error -hey check your scss-file");
            this.emit('end');
        })
        // extend autoprefixer for the last 3 browser versions
        .pipe(autoprefixer("last 3 version", "safari 5", "ie 9"))
        // pipe it to css folder
        .pipe(gulp.dest('app/css/'));
    console.log('new main-css has been written');
});


// gulp sass task 2: theme-sass-files file complile and keep them seperately
gulp.task('sass-theme', function(){
    // read all theme scss files
    gulp.src('app/scss/themes/*.scss')
        // pipe it to sass processor
        .pipe(sass())
        // prevent gulp from crashing due tu scss files
        .on('error', function (error){
            console.error("there was an syntax-Error in a theme sass style");
            this.emit('end');
        })

        // extend autoprefixer for the last 3 browser versions
        .pipe(autoprefixer("last 3 version", "safari 5", "ie 9"))
        // pipe it to css folder
        .pipe(gulp.dest('app/css/'));
    console.log('new Theme-css were written');
});


// gulp sass task3: media-queries sass-file concatination
gulp.task('sass-mq', function(){
    // read all scss files
    gulp.src('app/scss/media-queries/*.scss')
        // pipe it to sass processor
        .pipe(sass())
        // prevent gulp from crashing due to scss files
        .on('error', function (error){
            console.error("there was an Media-query scss syntax error -hey check your MQ-scss-file");
            this.emit('end');
        })

        // extend autoprefixer for the last 3 browser versions
        //.pipe(autoprefixer("last 3 version", "safari 5", "ie 9"))
        // pipe it to css folder
        .pipe(gulp.dest('app/css/'));
    console.log('new MediaQuerie-css has been written');
});





// gulp task-watcher function

gulp.task('watch', function(){
    var server = livereload(),
        reloadPage = function(evt){
            webserver.changed(evt.path);
        };
    console.log("reloaded");
    gulp.watch('app/scss/*.scss', ['sass']);
    gulp.watch('app/scss/themes/*.scss', ['sass-theme']);

    gulp.watch('app/scss/media-queries/*.scss', ['sass-mq']);
})



// default gulp function: start webserver, start watcher function
gulp.task('default', ['webserver', 'watch']);
