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
    .factory('CarBrand',function (Restangular) {
      return Restangular.service('base/carBrand');
    })
    .factory('WSC',function ($websocket) {
      //open a websocket connection
      var ws = $websocket("ws://localhost:8081/yyauto-web/linking");
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
  function dashboardCtrl($scope,$timeout,toastr,$http,WSC,CarBrand) {

    $scope.WSC = WSC;

    $scope.submit = function () {
      WSC.send("WSC SERVER");
    };

     CarBrand.one(368).get().then(function(data){
       console.log('CarBrand----',data);
     })



  }

})();
