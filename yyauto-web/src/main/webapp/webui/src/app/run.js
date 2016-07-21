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
      'ngCookies',
      'ngTouch',
      'ngSanitize',
      'ngMessages',
      'ngAria',
      'restangular',
      'ui.router',
      'mgcrea.ngStrap',
      'toastr'])

    .constant('malarkey', malarkey)
    .constant('moment', moment)

    .run(function ($log) {
      $log.debug('runBlock end');
    });

})();
