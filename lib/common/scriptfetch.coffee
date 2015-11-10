this.fetch = () ->
  scripts = document.getElementsByTagName 'script'
  path = scripts[scripts.length-1].src.split('?')[0]
  s = path.replace window.location.origin+window.location.pathname, ""
  console.log 'path', s
  mydir = s.split('/').slice(0, -1).join('/')+'/'
  #mydir.replace window.location.path, ''


