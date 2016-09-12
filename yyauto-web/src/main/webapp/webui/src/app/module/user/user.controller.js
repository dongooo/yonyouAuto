/**
 * description:用户登录模块
 * author: dongooo
 * create: 2016-07-25 上午10:11
 * php: https://github.com/dongooo
 **/

(function(){

  'use strict';
  angular.module('webui')

    .controller('userController',function ($scope,$log,$http,$auth) {

      //-------login start-------
      $auth.submitLogin($scope.loginForm)
        .then(function(resp) {
          // handle success response
        })
        .catch(function(resp) {
          // handle error response
        });


      //-------login end---------

      //
      // $scope.doLogin = function(){
      //   $http({
      //     method: 'POST',
      //     data: $scope.user,
      //     url: 'http://localhost:8081/yyauto-web/api/auth/login'
      //   }).then(function successCallback(response) {
      //     // this callback will be called asynchronously
      //     // when the response is available
      //     $scope.tokens = response.data.content;
      //     console.log($scope.tokens);
      //   }, function errorCallback(response) {
      //     // called asynchronously if an error occurs
      //     // or server returns response with an error status.
      //   });
      // }
      //
      // $scope.doLogout = function () {
      //   $http({
      //     method: 'DELETE',
      //     headers:{
      //       Authorization:$scope.tokens||undefined
      //     },
      //     url: 'http://localhost:8081/yyauto-web/api/auth/logout'
      //   }).then(function successCallback(response) {
      //     // this callback will be called asynchronously
      //     // when the response is available
      //   }, function errorCallback(response) {
      //     // called asynchronously if an error occurs
      //     // or server returns response with an error status.
      //   });
      // }
      //
      // $scope.getUserInfo =function () {
      //   $http({
      //     method: 'GET',
      //     headers:{
      //       Authorization:$scope.tokens||undefined
      //     },
      //     url: 'http://localhost:8081/yyauto-web/api/auth/getUserName'
      //   }).then(function successCallback(response) {
      //     // this callback will be called asynchronously
      //     // when the response is available
      //   }, function errorCallback(response) {
      //     // called asynchronously if an error occurs
      //     // or server returns response with an error status.
      //   });
      // }


    })

    .controller('404Controller',function ($log) {
      $log.debug('---404-controller--');
    })


})()
