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
  function config($logProvider, toastrConfig,RestangularProvider,$stateProvider,$httpProvider,$authProvider) {
    // Enable log
    $logProvider.debugEnabled(true);
    // $httpProvider.defaults.useXDomain = true;
    // delete $httpProvider.defaults.headers.common['X-Requested-With'];
    // $httpProvider.defaults.headers.common["Accept"] = "application/json";
    // $httpProvider.defaults.headers.common["Content-Type"] = "application/json";
    // Set options third-party lib
    toastrConfig.allowHtml = true;
    toastrConfig.timeOut = 3000;
    toastrConfig.positionClass = 'toast-top-right';
    toastrConfig.preventDuplicates = true;
    toastrConfig.progressBar = true;

    //set restangular
    RestangularProvider.setBaseUrl("http://localhost:8081/yyauto-web/api/");

    //权限控制
    $authProvider.configure({
      apiUrl:                  'http://localhost:8081/yyauto-web/api',
      //tokenValidationPath:     '/auth/tokenValidate',
      signOutUrl:              '/auth/logout',
      emailSignInPath:         '/auth/login',
      storage:                 'cookies',
      //forceValidateToken:      false,
      //validateOnPageLoad:      true,
      proxyIf:                 function() { return false; },
      proxyUrl:                '/proxy',
      omniauthWindowType:      'sameWindow',
      tokenFormat: {
        "Authorization": "token={{ token }}"
      },
      cookieOps: {
        path: "/",
        expires: 9999,
        expirationUnit: 'days',
        secure: false
      },
      createPopup: function(url) {
        return window.open(url, '_blank', 'closebuttoncaption=Cancel');
      },
      parseExpiry: function(headers) {
        // convert from UTC ruby (seconds) to UTC js (milliseconds)
        return (parseInt(headers['expiry']) * 1000) || null;
      },
      handleLoginResponse: function(response) {
        return response.data;
      },
      handleAccountUpdateResponse: function(response) {
        return response.data;
      },
      handleTokenValidationResponse: function(response) {
        return response.data;
      }
    });

    $stateProvider
    // this state will be visible to everyone
      .state('login', {
        url: '/',
        templateUrl: 'app/module/user/login.html',
        controller: 'userController',
        controllerAs: 'user'
      })

      // only authenticated users will be able to see routes that are
      // children of this state
      .state('admin', {
        url: '/admin',
        abstract: true,
        template: '<ui-view/>',
        resolve: {
          auth: function($auth) {
            //return $auth.validateUser();
            return $auth.validateUser({config: 'admin'})
          }
        }
      })

      // this route will only be available to authenticated users
      .state('admin.dashboard', {
        url: '/dashboard',
        templateUrl: 'app/module/dashboard/dashboard.html',
        controller: 'dashboardController'
      });

  }

})();

