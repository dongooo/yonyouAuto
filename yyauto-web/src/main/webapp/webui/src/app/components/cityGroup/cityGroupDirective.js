/**
 * Created by dongoo on 2015/8/17.
 * @description 封装省市县三层联动，省市关系-->如果code前俩个字符相等则市挂在某个省下，市县关系-->code前四个字符相等则县挂在某个市下面
 * @usage: <ANY city-group province="orgInfoList.province" city="orgInfoList.city" county="orgInfoList.county"></ANY>
 */
angular.module("yyauto.cityGroup",[])
  .factory('Data',function ($http) {
    return{
      get:function (_callBack) {
        $http.get('cityGroup.json',function (data) {
          _callBack(data);
        })
      }
    }
  })
  .filter('matchCode', ['$filter', '$timeout', function ($filter) {
    return function (_in, _code, _len) {
      var _sor, _isOut, _tar;
      return $filter('filter')(_in, function (item) {
        if (!_code) return !1;
        _sor = item.code.substring(0, _len);
        _tar = _code.substring(0, _len);
        _isOut = angular.equals(_sor, _tar);
        return _isOut;
      })
    }
  }])
  .controller('cityGroupController', function ($scope,Data) {
    $scope.dataSet = {'province': [], 'city': [], 'county': []};
    Data.get(function (_group) {
      angular.forEach(_group.data.chil, function (item) {
        $scope.dataSet.province.push(item);
        $scope.dataSet.city = $scope.dataSet.city.concat(item.chil);
      });

      angular.forEach($scope.dataSet.city, function (item) {
        $scope.dataSet.county = $scope.dataSet.county.concat(item.chil);
      });

    });

  })
  .directive('cityGroup', function () {
    return {
      restrict: 'EA',
      controller: 'cityGroupController',
      replace: true,
      scope: {'province': '=', 'city': '=', 'county': '=', 'default': '='},
      template: '<div class="row">' +
      '<div class="col-sm-4"><select ng-model="selected.pr" class="form-control input-sm"  ng-options="pr as pr.value for pr in dataSet.province track by pr.code"></select></div>' +
      '<div class="col-sm-4"><select ng-model="selected.ct" class="form-control input-sm"  ng-options="ct as ct.value for ct in dataSet.city | matchCode:selected.pr.code:2 track by ct.code"></select></div>' +
      '<div class="col-sm-4"><select ng-model="selected.co" class="form-control input-sm" ng-options="co as co.value for co in dataSet.county | matchCode:selected.ct.code:4 track by co.code"></select></div>' +
      '</div>',
      link: function (scope, attrs) {
        var seq = count = 0;

        var pccWatcher = scope.$watch('province+city+county', function () {
          scope.selected = {
            'pr': {code: scope.province},
            'ct': {code: scope.city},
            'co': {code: scope.county}
          };

          if (scope.default) {
            //是否设置默认值 - 上海-市辖区-黄浦区
            scope.selected = {
              'pr': {code:scope.province ||  '310000'},
              'ct': {code:scope.city ||  '310100'},
              'co': {code: scope.county || '310101'}
            };
          } else {
            scope.selected = {
              'pr': {code: scope.province},
              'ct': {code: scope.city},
              'co': {code: scope.county}
            };
          }
        });

        var prWatcher = scope.$watch('selected.pr', function (pr) {

          if (pr && pr.hasOwnProperty('chil')) {
            scope.dataSet.city = [];
            scope.dataSet.county = [];
            scope.dataSet.city = pr.chil;
          }
          if (!!seq && pr.hasOwnProperty('chil')) {
            scope.selected.ct = scope.dataSet.city[0];
            scope.selected.co = scope.dataSet.county[0];
          }
          ++seq;
        }, true);

        var ctWatcher = scope.$watch('selected.ct', function (ct) {

          if (ct && ct.hasOwnProperty('chil')) scope.dataSet.county = ct.chil;
          if (!!count && ct.hasOwnProperty('chil')) {
            scope.selected.co = scope.dataSet.county[0];
          }
          ++count;
        }, true);

        var selectedWatcher = scope.$watch('selected', function () {
          if (scope.selected.pr) scope.province = scope.selected.pr.code;
          if (scope.selected.ct) scope.city = scope.selected.ct.code;
          if (scope.selected.co) scope.county = scope.selected.co.code;
        }, true);

        scope.$on('$destroy', function () {
          prWatcher();
          ctWatcher();
          selectedWatcher();
          pccWatcher();
        });
      }
    }
  });
