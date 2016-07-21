/**
 * description:系统生产环境与开发环境配置
 * author: dongooo
 * create: 2016-07-21 下午12:37
 * php: https://github.com/dongooo
 **/
(function() {
  'use strict';

  angular.module('webui').config(config);

  /** @ngInject */
  function config($logProvider, toastrConfig) {
    // Enable log
    $logProvider.debugEnabled(true);

    // Set options third-party lib
    toastrConfig.allowHtml = true;
    toastrConfig.timeOut = 3000;
    toastrConfig.positionClass = 'toast-top-right';
    toastrConfig.preventDuplicates = true;
    toastrConfig.progressBar = true;
  }

})();

