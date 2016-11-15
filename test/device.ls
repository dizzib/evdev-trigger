test = it
<- describe 'device'

A = require \chai .assert
E = require \events
L = require \lolex
M = require \mockery

var T, clock, activity-count, stream-mock
fs-mock = createReadStream: -> stream-mock

after ->
  M.disable!
  clock.uninstall!
afterEach ->
  stream-mock.removeAllListeners!
  T.removeAllListeners!
  M.deregisterAll!
before ->
  M.enable warnOnUnregistered:false
  clock := L.install!
beforeEach ->
  M.registerMock \fs fs-mock
  activity-count := 0
  stream-mock := new E.EventEmitter
  T := new (require \../app/device) \/path/0 '*':run:\command
    .on \activity -> activity-count += 1

test 'valid chunk should raise activity event' -> run-activity 1 1
test 'separator chunk should not raise activity event' -> run-activity 0 0
test 'plugin device after startup' -> run-plugin-device 1
test 'unplug then replug device' -> run-activity 1 1; run-plugin-device 2

function run-activity val, expect-activity-count
  stream-mock.emit \data Buffer.allocUnsafe(24bytes).fill val
  A.equal expect-activity-count, activity-count

function run-plugin-device expect-activity-count
  stream-mock.emit \error (new Error 'no such device') with code:\ENODEV
  stream-mock.emit \error (new Error 'not found') with code:\ENOENT
  stream-mock := new E.EventEmitter
  clock.tick 5000ms
  run-activity 1 expect-activity-count
