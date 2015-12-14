(function() {
  var ACTIVE, COLLAPSED, EXPANDED, INACTIVE, NodeState, Sidebar, SidebarCssManager, SidebarDirective, directiveDir, merge,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  directiveDir = 'lib/components/sidebar/';

  ACTIVE = 0;

  INACTIVE = 1;

  COLLAPSED = 0;

  EXPANDED = 1;


  /*
  To convert an array of dict to a dict
  @param _L [Array<Dict>]
   */

  merge = function(_L) {
    var v;
    v = {};
    _.each(_L, function(_item) {
      return _.extend(v, _item);
    });
    return v;
  };


  /*
  To define sidebar css manager
   */

  SidebarCssManager = (function() {
    function SidebarCssManager() {}


    /*
    To control active style
    @param activation [emum] ACTIVE, INACTIVE
     */

    SidebarCssManager.getState = function(activation) {
      switch (activation) {
        case ACTIVE:
          return 'is-active';
        case INACTIVE:
          return '';
      }
    };


    /*
    To control arrowIcon direction
    @param expansion [enum] COLLAPSED, EXPANDED
     */

    SidebarCssManager.getExpansion = function(expansion) {
      switch (expansion) {
        case COLLAPSED:
          return 'fa fa-angle-down';
        case EXPANDED:
          return 'fa fa-angle-up';
        default:
          return '';
      }
    };


    /*
    To control expansion
    @param expansion [enum] COLLAPSED, EXPANDED
     */

    SidebarCssManager.expanded = function(expansion) {
      switch (expansion) {
        case COLLAPSED:
          return false;
        case EXPANDED:
          return true;
        default:
          return '';
      }
    };

    return SidebarCssManager;

  })();


  /*
  To abstract state for menu item, which is so-called Node
   */

  NodeState = (function() {

    /*
    To construct an instance of NodeState
    @param id [string] node name or subnode name
    @param content [object<dict>] node content
    @param hasFather [boolean/string] node father existence or father id
     */
    function NodeState(id, content, hasFather) {
      this.id = id;
      this.hasChildren = content ? content.subnodes !== void 0 : void 0;
      this.hasFather = hasFather != null ? hasFather : false;
      this.expansion = this.hasChildren ? COLLAPSED : void 0;
      this.activation = INACTIVE;
    }


    /*
    To activate node, including setting expansion and activation 
    retrun an activated node id and expanded node id
     */

    NodeState.prototype.activate = function() {
      var AK, EK;
      AK = EK = void 0;
      if (this.expansion !== void 0) {
        this.toggle();
        EK = this.expansion === EXPANDED ? this.id : void 0;
      } else {
        this.activation = ACTIVE;
        AK = this.id;
        EK = this.hasFather ? this.hasFather : void 0;
      }
      return [AK, EK];
    };


    /*
    To set expansion EXPANDED if it is COLLAPSED
     */

    NodeState.prototype.expand = function() {
      return this.expansion = this.expansion === COLLAPSED ? EXPANDED : void 0;
    };


    /*
    To toggle expansion value between COLLAPSED and EXPANDED
     */

    NodeState.prototype.toggle = function() {
      return this.expansion = this.expansion === COLLAPSED ? EXPANDED : COLLAPSED;
    };

    return NodeState;

  })();


  /*
  To define a sidebar model
  @extend Model
   */

  Sidebar = (function(superClass) {
    extend(Sidebar, superClass);


    /*
    To construct sidebar model
    @param rawData [Object] info data imported from user
     */

    function Sidebar(rawData) {
      this.rawData = _.filter(rawData, function(v) {
        return v !== void 0 && (_.keys(v)).length !== 0;
      });
      this.initStates();
    }


    /*
    To initialize the state of nodes, subnodes and turn them into a flat data structure
     */

    Sidebar.prototype.initStates = function() {
      var t;
      t = _.map(this.rawData, function(val, index) {
        var _tmp, sectionNodes;
        sectionNodes = _.map(val, function(nodeContent, nodeId) {
          var nodes, subnodes;
          nodes = {};
          nodes[nodeId] = new NodeState(nodeId, nodeContent, false);
          subnodes = _.mapObject(nodeContent.subnodes, function(_subnode, _subid) {
            return new NodeState(_subid, _subnode, nodeId);
          });
          _.extend(nodes, subnodes);
          return nodes;
        });
        return _tmp = merge(sectionNodes);
      });
      return this.states = merge(t);
    };


    /*
    To set states according to their keys
    @param nodeId [string] node id or subnode id
     */

    Sidebar.prototype.setStates = function(nodeId) {
      var activatedKey, expandedKey, ref;
      nodeId = nodeId !== void 0 && nodeId !== '' ? nodeId : (_.keys(this.states))[0];
      ref = nodeId && this.states[nodeId] ? this.states[nodeId].activate() : [void 0, void 0], activatedKey = ref[0], expandedKey = ref[1];
      if (expandedKey) {
        return this.states[expandedKey].expand();
      }
    };


    /*
    To toggle a sidebar item
    @param nid [String] node id
     */

    Sidebar.prototype.toggle = function(nid) {
      return this.states[nid].toggle();
    };


    /*
    To set user
    @param user [String] user name
     */

    Sidebar.prototype.setUser = function(user) {
      return this.user = user != null ? user : 'anonymous';
    };

    return Sidebar;

  })(Model);


  /*
  To define sidebar directive
  @extend Directive
   */

  SidebarDirective = (function(superClass) {
    extend(SidebarDirective, superClass);


    /*
    To construct an instance of SidebarDirective
    @param params [Dict] parameters of angular directive
    @param cssKlass [Class] css management class for sidebar
     */

    function SidebarDirective(params, cssKlass) {
      var asideParams;
      params = params != null ? params : {};
      cssKlass = cssKlass != null ? cssKlass : SidebarCssManager;
      asideParams = {
        templateUrl: directiveDir + 'sidebar.html',
        scope: {
          activeItem: "=",
          user: "="
        }
      };
      _.extend(params, asideParams);
      SidebarDirective.__super__.constructor.call(this, params, Sidebar, cssKlass);
    }


    /*
    To initialize link function of table directive
     */

    SidebarDirective.prototype.linkFn = function(scope, element, attr) {
      SidebarDirective.__super__.linkFn.call(this, scope, element, attr);

      /*
      scope.$watch () ->
        scope.activeItem
      , (nV, oV) ->
        scope.setActiveItem nV
       */

      /*
      To set ACTIVE state to node or subnode according to activeItem
      @param item [string] node name or subnode name
       */
      scope.model.setStates(scope.activeItem);
      return scope.model.setUser(scope.user);

      /*
      scope.setActiveItem = (item) ->
        scope.model.initStates()
        scope.activeItem = item
        scope.model.setStates scope.activeItem
       */
    };

    return SidebarDirective;

  })(Directive);

  this.SidebarDirective = SidebarDirective;

}).call(this);
