/**
 * description:系统启动入口
 * author: dongooo
 * create: 2016-07-21 下午12:40
 * php: https://github.com/dongooo
 **/

(function() {
  'use strict';

  angular
    .module('webui', [
      'ngAnimate',
      'ipCookie',
      'ngTouch',
      'ngSanitize',
      'ngMessages',
      'ngAria',
      'restangular',
      'ui.router',
      'ng-token-auth',
      'mgcrea.ngStrap',
      'toastr',
      'ngWebSocket',
      'angular-jwt'
    ])

    .constant('malarkey', malarkey)
    .constant('moment', moment)

    .run(function ($log,$rootScope,Restangular) {
     // $log.debug('runBlock end');
    });

})();
