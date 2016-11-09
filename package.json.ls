name       : \evdev-trigger
version    : \0.1.0
description: "A command-line tool to run shell commands on evdev activity."
keywords   : <[ command evdev exec shell trigger X11 ]>
homepage   : \https://github.com/dizzib/evdev-trigger
bugs       : \https://github.com/dizzib/evdev-trigger/issues
license:   : \MIT
author     : \dizzib
bin        : \./bin/evdev-trigger
repository :
  type: \git
  url : \https://github.com/dizzib/evdev-trigger
scripts:
  start: './task/bootstrap && node ./_build/task/repl'
  test : './task/bootstrap && node ./_build/task/npm-test'
dependencies:
  async      : \2.1.2
  commander  : \2.9.0
  leanconf   : \0.2.1
  x11        : \2.2.0
devDependencies:
  chai       : \~3.5.0
  chalk      : \~0.4.0
  chokidar   : \~1.6.0
  cron       : \~1.1.1
  growly     : \~1.3.0
  istanbul   : \~0.4.5
  livescript : \~1.5.0
  lodash     : \~4.16.6
  lolex      : \~1.5.1
  mocha      : \~3.1.2
  mockery    : \~2.0.0
  shelljs    : \~0.3.0
  'wait.for' : \~0.6.6
engines:
  node: '>=0.10.x'
  npm : '>=1.0.x'
preferGlobal: true
