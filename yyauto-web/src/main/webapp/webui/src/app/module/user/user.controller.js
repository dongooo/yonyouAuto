/**
 * description:用户登录模块
 * author: dongooo
 * create: 2016-07-25 上午10:11
 * php: https://github.com/dongooo
 **/

(function(){

  'use strict';
  angular.module('webui')
    .config(function ($stateProvider,$urlRouterProvider) {
      $stateProvider
        .state('login', {
          url: '/user/login',
          templateUrl: 'app/module/user/login.html',
          controller: 'userController',
          controllerAs: 'user'
        })
        .state('404', {
          url: '/user/404',
          templateUrl: 'app/module/user/404.html',
          controller: '404Controller',
          controllerAs: '404'
        });

      $urlRouterProvider.otherwise('/user/404')
    })

    .controller('userController',function ($scope,$log) {
        $log.debug('---user-controller--');
    })

    .controller('404Controller',function ($log) {
      $log.debug('---404-controller--');
    })


})()
