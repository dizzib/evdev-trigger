Assert = require \assert
Shell  = require \shelljs/global

const DIRNAME =
  BUILD: \_build
  APP  : \app
  TASK : \task
  TEST : \test

root = pwd!

dir =
  BUILD: "#root/#{DIRNAME.BUILD}"
  build:
    APP : "#root/#{DIRNAME.BUILD}/#{DIRNAME.APP}"
    TASK: "#root/#{DIRNAME.BUILD}/#{DIRNAME.TASK}"
    TEST: "#root/#{DIRNAME.BUILD}/#{DIRNAME.TEST}"
  ROOT : root
  APP  : "#root/#{DIRNAME.APP}"
  TASK : "#root/#{DIRNAME.TASK}"
  TEST : "#root/#{DIRNAME.TEST}"

module.exports =
  APPNAME: \evdev-trigger
  dirname: DIRNAME
  dir    : dir

Assert test \-e dir.APP
Assert test \-e dir.TASK
Assert test \-e dir.TEST
