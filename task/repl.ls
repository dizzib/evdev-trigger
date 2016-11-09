global.log = console.log

Chalk  = require \chalk
_      = require \lodash
Rl     = require \readline
Shell  = require \shelljs/global
WFib   = require \wait.for .launchFiber
App    = require \./app
Build  = require \./build
Consts = require \./constants
DirBld = require \./constants .dir.BUILD
Dist   = require \./distribute
Inst   = require \./install
G      = require \./growl
Test   = require \./test

const CHALKS = [Chalk.stripColor, Chalk.yellow, Chalk.red]
const COMMANDS =
  * cmd:'h   ' level:0 desc:'help    - show commands'         fn:show-help
  * cmd:'i.d ' level:0 desc:'install - delete node_modules'   fn:Inst.delete-modules
  * cmd:'i.r ' level:0 desc:'install - refresh node_modules'  fn:Inst.refresh-modules
  * cmd:'b.a ' level:0 desc:'build   - all'                   fn:build-all
  * cmd:'b.d ' level:0 desc:'build   - delete'                fn:Build.delete-files
  * cmd:'r   ' level:0 desc:'app     - recycle'               fn:App.recycle
  * cmd:'t   ' level:0 desc:'test    - run'                   fn:Test.run
  * cmd:'d.lo' level:1 desc:'distrib - publish to local dir'  fn:Dist.publish-local
  * cmd:'d.PU' level:2 desc:'distrib - publish to public npm' fn:Dist.publish-public

config.fatal  = true # shelljs doesn't raise exceptions, so set this process to die on error
#config.silent = true # otherwise too much noise

cd DirBld # for safety, set working directory to build

for c in COMMANDS then c.display = "#{Chalk.bold CHALKS[c.level] c.cmd} #{c.desc}"

rl = Rl.createInterface input:process.stdin, output:process.stdout
  ..setPrompt "#{Consts.APPNAME} >"
  ..on \line (cmd) ->
    <- WFib
    rl.pause!
    for c in COMMANDS when cmd is c.cmd.trim!
      try c.fn!
      catch e then log e
    rl.resume!
    rl.prompt!

Build.on \built ->
  Dist.prepare!
  <- App.stop
  err <- Test.run
  return log err if err
  err <- App.start
  log err if err
Build.start!
App.recycle!

_.delay show-help, 500ms
_.delay (-> rl.prompt!), 750ms

# helpers

function build-all
  try Build.all!
  catch e then G.err e

function show-help
  for c in COMMANDS then log c.display
