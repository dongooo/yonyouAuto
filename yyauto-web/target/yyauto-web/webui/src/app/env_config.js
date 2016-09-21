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
  function config($logProvider, toastrConfig,RestangularProvider,$stateProvider,$httpProvider,$injector,$authProvider,$urlRouterProvider) {

    RestangularProvider.addResponseInterceptor(function(data, operation, what, url, response, deferred) {
      var extractedData;
      if (operation === "getList") {
        extractedData = data.body;
        extractedData.error = data.error;
        extractedData.paging = data.paging;
      } else {
        extractedData = data.data;
      }
      return extractedData;
    });

    //拦截数据
    $httpProvider.interceptors.push([
      '$injector', function($injector) {
        return {
          request: function(req) {
            $injector.invoke([
              '$http', '$auth','jwtHelper','$state', function($http, $auth,jwtHelper,$state) {
                var token,isExpiry=!1,isHasToken;
                token = $auth.retrieveData('access_token');
                isHasToken = (token == ''||token == void 0||token == null)?false:true;
                if(isHasToken){
                  isExpiry = jwtHelper.isTokenExpired(token);
                }

                if (req.url.match($auth.apiUrl())) {
                  if(isHasToken&&!isExpiry){
                    return req.headers['access-token'] = token;
                  }else{
                    $state.go('login');
                  }


                }
              }
            ]);
            return req;
          },
          response: function(resp) {
            $injector.invoke([
              '$http', '$auth', function($http, $auth) {
                if (resp.config.url.match($auth.apiUrl())) {
                  return resp;
                }
              }
            ]);
            return resp;
          },
          responseError: function(resp) {
            $injector.invoke([
              '$http', '$auth','$state', function($http, $auth,$state) {
                if (resp.config.url.match($auth.apiUrl())) {
                  if(resp.status ==401&&resp.data==401){
                    $state.go('login');
                  }else{
                    return resp;
                  }
                }
              }
            ]);
            return $injector.get('$q').reject(resp);
          }
        };
      }
    ]);



    // Enable log
    $logProvider.debugEnabled(true);

    toastrConfig.allowHtml = true;
    toastrConfig.timeOut = 3000;
    toastrConfig.positionClass = 'toast-top-right';
    toastrConfig.preventDuplicates = true;
    toastrConfig.progressBar = true;

    //set restangular
    RestangularProvider.setBaseUrl("http://localhost:8081/yyauto-web/api/");

    //登录认证
    $authProvider.configure({
      apiUrl:                  'http://localhost:8081/yyauto-web/api',
      tokenValidationPath:     '/auth/tokenValidate',
      signOutUrl:              '/auth/logout',
      emailSignInPath:         '/auth/login',
      storage:                 'cookies',
      //forceValidateToken:      false,
      validateOnPageLoad:      true,
      proxyIf:                 function() { return false; },
      proxyUrl:                '/proxy',
      omniauthWindowType:      'sameWindow',
      tokenFormat: {
        "access-token": "{{ token }}",
        "client":       "{{ clientId }}",
        "expiry":       "{{ expiry }}",
        "uid":          "{{ uid }}"
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
      .state('login', {
        url: '/',
        templateUrl: 'app/module/user/login.html',
        controller: 'userController',
        controllerAs: 'user'
      })

      .state('admin', {
        url: '/admin',
        abstract: true,
        template: '<div ui-view></div>',
        resolve: {
          auth: function($auth,jwtHelper,$state,$location,$timeout) {
             var token,isExpiry=!0,isHasToken,currentUrl;
             token = $auth.retrieveData('access_token');
             isHasToken = (token == ''||token == void 0||token == null)?false:true;
             //currentUrl = $location.$$url;
            if(isHasToken){
              isExpiry = jwtHelper.isTokenExpired(token);
            }
            if(!isHasToken&&isExpiry){
              $timeout(function () {
                $state.go('login');
              },0)
            }
            //todo
            //若登录,处理当前路由
            //else{
              //$location.path(currentUrl);
             // $rootScope.$apply();
            //}
            $auth.resolveDfd();
          }
        }
      })

      // this route will only be available to authenticated users
      .state('dashboard', {
        parent:'admin',
        url: '/dashboard',
        templateUrl: 'app/module/dashboard/dashboard.html',
        controller: 'dashboardController'
      })
      .state('404', {
        parent:'admin',
        url: '/404',
        templateUrl: 'app/module/user/404.html'
      })
    ;

    $urlRouterProvider.otherwise(function($injector, $location){
      $injector.invoke(['$state', function($state) {
        $state.go('404');
      }]);
    });



  }

})();

