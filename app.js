var app = angular.module("tableOBJ",[]);


app.directive('tableObj', function() {
    return {
        templateUrl: 'table.html',
        controller:function($scope){
            $scope.books = [
                {title:'c',price:'10',desc:'c book'},
                {title:'c++',price:'11',desc:'c++ book'},
                {title:'java',price:'12',desc:'java book'}
            ]
        }
    };
});

app.directive('tdObj',function(){

    var tdObj = {
        template:'<span ng-click="showDetail(tdValue)">{{tdValue}}</span>',
        scope:{tdValue:'@',attr:'@'},
        controller:function($scope){
            $scope.showDetail = function(){
                $scope.tdValue = 'Bob'
                $scope.$emit('changeName',$scope.tdValue)
            };

        }
    };

    return tdObj
});

app.controller('tabCtl',['$scope',function($scope){

    $scope.$on('changeName',function(event,data){
        console.log('data',data)
        console.log('$scope.parentName',$scope.parentName)
    })

    $scope.parentName = 'Tom'
}]);


