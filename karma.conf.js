'use strict';

var path = require('path');

module.exports = function (config) {
  config.set({
    basePath: '',
    frameworks: ['jasmine'],
    files: [
      'test/helpers/**/*.js',
      'test/spec/**/*.cjsx',
      'test/spec/**/*.coffee'
    ],
    preprocessors: {
      'test/spec/**/*.cjsx': ['webpack'],
      'test/spec/**/*.coffee': ['webpack']
    },
    webpack: {
      cache: true,
      module: {
        loaders: [{
          test: /\.gif/,
          loader: 'url-loader?limit=10000&mimetype=image/gif'
        }, {
          test: /\.jpg/,
          loader: 'url-loader?limit=10000&mimetype=image/jpg'
        }, {
          test: /\.png/,
          loader: 'url-loader?limit=10000&mimetype=image/png'
        }, {
          test: /\.jsx$/,
          exclude: /node_modules/,
          loader: 'jsx-loader?harmony'
        }, {
          test: /\.cjsx$/,
          exclude: /node_modules/,
          loaders: ['coffee', 'cjsx']
        }, {
          test: /\.coffee$/,
          exclude: /node_modules/,
          loader: 'coffee'
        }, {
          test: /\.styl/,
          loader: 'style-loader!css-loader!stylus-loader'
        }, {
          test: /\.css$/,
          loader: 'style-loader!css-loader'
        }]
      },
      resolve: {
        extensions: ['', '.js', '.coffee', '.cjsx'],
        alias: {
          'styles': path.join(process.cwd(), './src/styles/'),
          'components': path.join(process.cwd(), './src/scripts/components/'),
          'helpers':    path.resolve(process.cwd(), 'src/scripts/helpers'),
          'src':        path.resolve(process.cwd(), 'src'),
          'config':     path.join(process.cwd(), './src/config')
        }
      }
    },
    webpackServer: {
      stats: {
        colors: true
      }
    },
    exclude: [],
    port: 8080,
    logLevel: config.LOG_INFO,
    colors: true,
    autoWatch: false,
    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers: ['PhantomJS'],
    reporters: ['progress'],
    captureTimeout: 60000,
    singleRun: true
  });
};
