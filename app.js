var app = angular.module("tableOBJ",[]);


app.directive('tableObj', function() {
    return {
        templateUrl: 'table.html',
        controller:function($scope){
            $scope.showId = 0;
            $scope.books = [
                {id:1,title:'c',price:'10',desc:'c book'},
                {id:2,title:'c++',price:'11',desc:'c++ book'},
                {id:3,title:'java',price:'12',desc:'java book'}
            ]

            $scope.showDetail = function(book){
                console.log('@@@@',book)
                if(book.id == $scope.showId){
                    $scope.showId = 0;
                }else{
                    $scope.showId = book.id;
                }
            }
        }
    };
});

app.directive('tdObj',function(){

    var tdObj = {
        template:'<span ng-click="clickFnc" ng-bind="{{tdValue}}.{{attr}}"></span>',
        scope:{tdValue:'@',attr:'@',clickFnc:'&'},
        controller:function($scope){
            console.log('====',$scope.clickFnc)
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


