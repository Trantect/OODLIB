lib = angular.module "OODLib", []

ctableConfig =
  restrict: 'E'
  templateUrl: 'build/table/table.html'
  scope:
    storage: '=info'
  link: (scope, element, attr) ->
    events =
      'click': () ->
        alert 'click event fired'
    EventRegister.register element, events


Directive.register lib, 'ctable', ctableConfig

