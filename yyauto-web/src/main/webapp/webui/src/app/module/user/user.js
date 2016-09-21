/**
 * description:用户登录模块
 * author: dongooo
 * create: 2016-07-25 上午10:11
 * php: https://github.com/dongooo
 **/

(function(){

  'use strict';
  angular.module('webui')

    .controller('userController',function ($scope,$log,$http,$auth,$state,jwtHelper) {

      $scope.submitLogin = function (user) {
        if(angular.equals(user.userName,void 0)||angular.equals(user.password,void 0)){
          alert('请输入用户名或密码!');
          return !1;
        }
        $auth.submitLogin(user).then(function (res) {
          $auth.persistData("access_token",res.access_token);
          $state.go("dashboard");
        });
      }


    })

    .controller('404Controller',function ($log) {
      $log.debug('---404-controller--');
    })


})()
