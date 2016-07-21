/**
 * description:系统登录后展示页
 * author: dongooo
 * create: 2016-07-21 下午15:00
 * php: https://github.com/dongooo
 **/

(function() {
  'use strict';

  angular
    .module('webui')
    .config(function ($stateProvider, $urlRouterProvider) {
      $stateProvider
        .state('dashboard', {
          url: '/',
          templateUrl: 'app/module/dashboard/dashboard.html',
          controller: 'dashboardCtrl',
          controllerAs: 'dashboard'
        });

      $urlRouterProvider.otherwise('/');
    })
    .controller('dashboardCtrl', dashboardCtrl);

  /** @ngInject */
  function dashboardCtrl($timeout, webDevTec, toastr) {
      console.log('----dashboard----');
    //todo

  }

})();
