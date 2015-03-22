'use strict';

describe('Main', function () {
  var React = require('react/addons');
  var TestTaskApp, component;

  beforeEach(function () {
    var container = document.createElement('div');
    container.id = 'content';
    document.body.appendChild(container);

    TestTaskApp = require('components/TestTaskApp.js');
    component = React.createElement(TestTaskApp);
  });

  it('should create a new instance of TestTaskApp', function () {
    expect(component).toBeDefined();
  });
});
