angular.module('gettext').run(['gettextCatalog', function (gettextCatalog) {
/* jshint -W100 */
    gettextCatalog.setStrings('zh', {"details":"详情","records":"条记录","total":"总共"});
/* jshint +W100 */
}]);