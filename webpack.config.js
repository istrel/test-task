/*
 * Webpack development server configuration
 *
 * This file is set up for serving the webpack-dev-server, which will watch for changes and recompile as required if
 * the subfolder /webpack-dev-server/ is visited. Visiting the root will not automatically reload.
 */
'use strict';
var webpack = require('webpack');
var path = require('path');

module.exports = {

  output: {
    filename: 'main.js',
    publicPath: '/assets/'
  },

  cache: true,
  debug: true,
  devtool: false,
  entry: [
      'webpack/hot/only-dev-server',
      './src/scripts/Main.cjsx'
  ],

  stats: {
    colors: true,
    reasons: true
  },

  resolve: {
    extensions: ['', '.js', '.coffee', '.cjsx'],
    alias: {
      'styles':     path.resolve(__dirname, 'src/styles'),
      'components': path.resolve(__dirname, 'src/scripts/components'),
      'helpers':    path.resolve(__dirname, 'src/scripts/helpers'),
      'src':        path.resolve(__dirname, 'src'),
      'config':     path.resolve(__dirname, 'src/config')
    }
  },
  module: {
    preLoaders: [{
      test: /\.jsx$/,
      exclude: /node_modules/,
      loader: 'jsxhint'
    }],
    loaders: [{
      test: /\.jsx$/,
      exclude: /node_modules/,
      loader: 'react-hot!jsx-loader?harmony'
    }, {
      test: /\.cjsx$/,
      exclude: /node_modules/,
      loaders: ['react-hot', 'coffee', 'cjsx']
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
    }, {
      test: /\.(png|jpg)$/,
      loader: 'url-loader?limit=8192'
    }]
  },

  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin()
  ]

};
