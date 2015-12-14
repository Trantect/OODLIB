angular.module('gettext').run(['gettextCatalog', function (gettextCatalog) {
/* jshint -W100 */
    gettextCatalog.setStrings('zh', {"Hello, {{model.user}}":"你好, {{model.user}}"});
/* jshint +W100 */
}]);