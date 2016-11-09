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
  test 'with overridden config-path' ->
    args.is-default-config-path = false
    T.load!; A.isNull T.get!

test 'empty' -> run \empty {}

test.skip 'updated file should auto-reload' (done) ->

describe.skip 'error' ->
  function run id, expect then prepare id; A.throws T.load, expect
  test 'malformed' -> run \malformed ''
