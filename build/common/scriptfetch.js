(function() {
  this.fetch = function() {
    var mydir, path, s, scripts;
    scripts = document.getElementsByTagName('script');
    path = scripts[scripts.length - 1].src.split('?')[0];
    s = path.replace(window.location.origin + window.location.pathname, "");
    console.log('path', s);
    return mydir = s.split('/').slice(0, -1).join('/') + '/';
  };

}).call(this);
