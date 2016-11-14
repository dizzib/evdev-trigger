test = it
<- describe 'config'

A = require \chai .assert
S = require \shelljs/global
M = require \mockery

var args, T
deq = A.deepEqual

after ->
  M.deregisterAll!
  M.disable!
before ->
  M.enable warnOnUnregistered:false
  M.registerMock \./args args := config-path:\/tmp/evdev-trigger.conf
  T := require \../app/config
beforeEach ->
  T.reset!

function expect then deq T.load!get!, it
function prepare then cp \-f "./test/config/#it.conf" args.config-path
function run id, exp then prepare id; expect exp

describe 'missing' ->
  beforeEach -> rm \-f args.config-path
  test 'with default config-path should copy default.conf' ->
    args.is-default-config-path = true
    expect do
      '/dev/input/event0':'*': run:'echo 0'
      '/dev/input/event1':'*': run:'echo 1'
  test 'with overridden config-path' ->
    args.is-default-config-path = false
    T.load!; A.isNull T.get!

test 'empty' -> run \empty {}

test 'updated file should auto-reload' (done) ->
  run \event0 '/dev/input/event0':'*': run:'echo 0'
  prepare \event1
  setTimeout (-> deq T.get!, '/dev/input/event1':'*': run:'echo 1'; done!), 5

describe 'error' ->
  function run id, expect then prepare id; A.throws T.load, expect
  test 'bad-path' -> run \bad-path 'Bad path'
  test 'bad-rule-filter' -> run \bad-rule-filter 'Bad rule filter'
  test 'missing-rule-run' -> run \missing-rule-run 'Bad rule'
  test 'empty-rule-run' -> run \empty-rule-run 'Bad rule'
