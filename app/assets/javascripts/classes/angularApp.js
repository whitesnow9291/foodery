var app = angular.module('myApp', []);
  app.controller('myCtrl', ["$scope", "$http", function($scope, $http) {
    $scope.count = 1;
    $scope.url = $(".menuItem-option-container").data('url');
    $scope.base_price = parseFloat($(".amount").data("price"));
    $scope.price = parseFloat($(".amount").data("price"));
    $scope.option_price = 0.00;
    
    $scope.addItem = function(){
      $scope.count += 1
      $scope.countPrice();
    }
    $scope.subItem = function(){
      $scope.count -= 1
      $scope.countPrice();
    }
    
    $scope.optionPrice = function(){
      $scope.option_price = 0.00
      $('input.menuItem-option-val').each(function() {
        if ($(this).is(':checked')) {
          $scope.option_price += parseFloat($(this).data('price'));
        }
      });
     }
    $scope.countPrice = function() {
      $scope.optionPrice();
      $scope.price = ($scope.base_price + $scope.option_price) * $scope.count ;
    };
    $scope.submit = function(){
      $scope.data = {};
       $scope.data.options = [];
      $('input.menuItem-option-val').each(function() {
        if ($(this).is(':checked')) {
          $scope.data.options.push({id: $(this).val()});
        }
      });
      if ($scope.data.options.length <= 0) {
        $scope.data.options = '';
      }
      if ($scope.count >= 1) {
        $scope.data.count = $scope.count;
      }
      $http.post($scope.url,$scope.data)
      .then(function(data) {
        $scope.container = $('.modal-container');
        console.log(data);
        console.log($scope.container);
        if (!!data.data.error) {
          $scope.container.html(data.data.modal_html);
          $(data.data.modal_selector).modal('show');
          new Loader($scope.container);
          return;
        }
        if (data.data.is_modal) {
          $scope.container.html(data.data.modal_html);
          $(data.data.modal_selector).modal('show');
          return new Loader($scope.container);
        } else {
          $('.my-order-box').html(data.data.html);
          $('#mobile-order').html(data.data.mobile_html);
          $('#bag-order-notification').show();
          if (!!data.data.modal_selector) {
            return $(data.data.modal_selector).modal('hide');
          }
        }
      })
    }
  }]);