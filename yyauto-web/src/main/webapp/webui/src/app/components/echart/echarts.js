/**
 * Created by dongoo on 2016/9/22.
 */
'use strict';
angular.module('uchezhan.echarts', [])
  .directive('echarts', function () {
    return{
      scope:{
        echarts:'=',
        option:'=',
        notMerge:'=',
        on:'=',
        loading:'=',
        static:'='
      },
      link: function (scope, element, attrs) {
        // 获取echart对象
        var _chart = scope.echarts = echarts.init(element[0]);
        _chart.name = attrs.echarts;

        // 设置数据
        var unWatchOption = scope.$watch('option', function (_option) {
          if(_option){
            _chart.setOption(_option,scope.notMerge);
            _chart.hideLoading();
            if(scope.static){
              unWatchOption();
              unWatchLoading();
            }
          }
        });

        // 显示loading
        var unWatchLoading = scope.$watch('loading', function (_isLoading) {
          if(_isLoading){
            _chart.showLoading(_isLoading);
          }else{
            _chart.hideLoading();
          }
        });

        // 自动调整尺寸
        scope.$watch(function () {
          return element.width() + element.height();
        }, function () {
          _chart.resize();
        });

        // 绑定事件
        if(scope.on){
          for (var event in scope.on) {
            _chart.on(echarts.config.EVENT[event], scope.on[event]);
          }
        }

        //注销echart控件,清除动画定时器。
        scope.$on('$destroy', function () {
          _chart.dispose();
        })
      }
    }
  });
