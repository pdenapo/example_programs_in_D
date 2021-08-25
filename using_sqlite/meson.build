# Alternative build script using meson
# Compilarlo usando
# 
# DC="dmd" meson  setup build_dir
# ninja -C ./build_dir/

project('using_sqlite', 'd',
  version : '0.1',
  default_options : ['warning_level=3'])

d2sqlite3_dep = dependency('d2sqlite3', method : 'dub') 
executable('using_sqlite', './source/app.d',dependencies:[d2sqlite3_dep]) 