/**
 * description:全局数据请求与响应的拦截
 * author: dongooo
 * create: 2016-09-16 下午9:28
 * php: https://github.com/dongooo
 **/
(function () {
  'use strict';
  angular.module('webui')
    .service('HttpInterceptor',['$httpProvider','$q','jwtHelper','$state','$injector',function ($httpProvider,$q,jwtHelper,$state,$injector) {
      return {
          'request': function(config) {
                     // do something on success
            console.log(config);
                  config.headers['access-token'] = 'xxxx';
                     return config;
                  },

               // optional method
              'requestError': function() {
              //  // do something on error
              // if (canRecover(rejection)) {
              //      return responseOrNewPromise
              //        }
              //  return $q.reject(rejection);
             },

             // optional method
             'response': function(response) {
               // do something on success
               return response;
             },

             // optional method
            'responseError': function(rejection) {
               // do something on error
               if (canRecover(rejection)) {
                 return responseOrNewPromise
                    }
              return $q.reject(rejection);
            }
      };
    }])
});
