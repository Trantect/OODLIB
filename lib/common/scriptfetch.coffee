this.fetch = () ->
  scripts = document.getElementsByTagName 'script'
  path = scripts[scripts.length-1].src.split('?')[0]
  mydir = path.split('/').slice(0, -1).join('/')+'/'


