angular.module('OOD_Table').run(['$templateCache', function ($templateCache) {
	$templateCache.put('./lib/components/table/table.html', '<div class="responsive"> <table class="table table-sort table-detail-default table-stripped-4"> <thead> <tr> <th ng-repeat="t in model.columnFields" ng-click="model.sortBy(t)"> <span ng-bind="model.getTitle(t)"></span><i ng-class="css.sortState(model.getSortOrder(t))"></i></th> </tr> </thead> <tbody> <tr ng-repeat-start="item in model.currentData" ng-click="model.toggleDetail($index)" ng-class="css.brief(item)"> <td ng-repeat="(k,v) in item.columnData" ng-class="css.td(item.columnData)"><span ng-class="css.cell(k,v)"><i ng-class="css.cellIcon(k,v)"></i><span ng-bind="v" class="css.cellContent(k,v)"></span></span></td> </tr> <tr ng-repeat-end="ng-repeat-end" ng-show="model.detailDisplayed($index)" ng-class="css.detail(item)"> <td colspan="{{model.columnFields.length}}" class="is-nopadding"> <div class="detail-default"> <div translate="translate" class="detail-title">details</div> <dl> <dt ng-repeat-start="(k,v) in item.detailData">{{model.getTitle(k)}}:</dt> <dd ng-repeat-end="(k,v) in item.detailData">{{v}}</dd> </dl> </div> </td> </tr> </tbody> </table> <div class="statistics"> <span> <span translate="translate">total</span><span ng-bind="model.data.length"> </span><span translate="translate">records</span></span> <ul ng-show="model.data.length&gt;0" class="pagination"> <li ng-class="css.prevPageState(model.currentPage)" ng-click="model.setCurrentPage(model.currentPage-1)"><a href="#">«</a></li> <li ng-repeat="i in model.pageRange" ng-click="model.setCurrentPage(i)" ng-class="css.pageState(model.currentPage, i)"><a href="#">{{i}}</a></li> <li ng-class="css.nextPageState(model.currentPage, model.numPages)" ng-click="model.setCurrentPage(model.currentPage+1)"><a href="#">»</a></li> </ul> </div> </div>');
}]);