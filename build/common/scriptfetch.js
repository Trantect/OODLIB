(function() {
  this.fetch = function() {
    var mydir, path, scripts;
    scripts = document.getElementsByTagName('script');
    path = scripts[scripts.length - 1].src.split('?')[0];
    return mydir = path.split('/').slice(3, -1).join('/') + '/';
  };

}).call(this);
