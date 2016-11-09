global.log = console.log

_      = require \lodash
WFib   = require \wait.for .launchFiber
Build  = require \./build
DirBld = require \./constants .dir.BUILD
Test   = require \./test

cd DirBld
Build.start!
_.delay run, 1000 # give chokidar time to build its _watched

function run
  <- WFib
  Build.all!
  Build.stop!
  res = Test.exec!
  process.exit res.code
