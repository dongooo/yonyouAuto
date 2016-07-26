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
          controller: 'dashboardController',
          controllerAs: 'dashboard'
        });

      $urlRouterProvider.otherwise('/');
    })
    .factory('WSC',function ($websocket) {
      //open a websocket connection
      var ws = $websocket("ws://"+document.location.host+document.location.pathname+"linking");
      var wsc = [];
      ws.onMessage(function (event) {
        console.log('message: ',event.data);
        var response;
        try{
          response = angular.fromJson(event.data);
        }catch (e){
          document.getElementById("wsid").innerHTML = "Sorry,connection failed...";
          console.log("error: ",e);
          response = {"error: ":e};
        }

        if(response.hello){
          document.getElementById("wsid").innerHTML = response.hello;
        }else {
          for(var len = response.length;len>=0;len--){
            wsc.push({"rank":response[i].rank,"name":response[i].name,"email":response[i].email});
          }
        }
      });

      ws.onError(function (event) {
        console.log('connection Error ',event);
      });

      ws.onClose(function (event) {
        console.log('connection Closed ',event);
      });

      ws.onOpen(function () {
        console.log('connection open');
        ws.send('HELLO SERVER');
      });

      return{
        wsc:wsc,
        status:function () {
          return ws.readyState;
        },
        send:function (message) {
          if(angular.isString(message)){
            ws.send(message);
          }else if(angular.isObject(message)){
            ws.send(JSON.stringify(message));
          }
        }
      };


    })
    .controller('dashboardController', dashboardCtrl);

  /** @ngInject */
  function dashboardCtrl($scope,$timeout,toastr,$http,WSC) {
      console.log('----dashboard----');

    $scope.WSC = WSC;

    $scope.submit = function () {
      WSC.send("WSC SERVER");
    };


    $http({
      method: 'GET',
      url: 'http://localhost:8081/yyauto-web/base/carBrand?id=368'
    }).then(function successCallback(response) {
      // this callback will be called asynchronously
      // when the response is available
    }, function errorCallback(response) {
      // called asynchronously if an error occurs
      // or server returns response with an error status.
    });
    //todo

  }

})();
