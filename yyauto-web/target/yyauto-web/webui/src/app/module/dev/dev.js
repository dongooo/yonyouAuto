/**
 * description:
 * author: dongooo
 * create: 2016-07-21 下午3:55
 * php: https://github.com/dongooo
 **/
(function () {
  'use strict';

  angular
    .module('webui')
    .config(function ($stateProvider, $urlRouterProvider) {
      $stateProvider
        .state('dev', {
          url: '/dev',
          templateUrl: 'app/module/dev/dev.html',
          controller: 'devController',
          controllerAs: 'dev'
        });

      $urlRouterProvider.otherwise('/');
    })
    .controller("devController",function ($scope,$log) {
      //todo
      $log.info('---dev---');
    });

})();

