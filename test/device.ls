test = it
<- describe 'device'

A = require \chai .assert
E = require \events
L = require \lolex
M = require \mockery

var T, clock, activity-count
stream-mock = new E.EventEmitter
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
  T := new (require \../app/device) \/path/0 '*':run:\command
    .on \activity -> activity-count += 1

test 'valid chunk should raise activity event' -> run-activity 1 1
test 'separator chunk should not raise activity event' -> run-activity 0 0

test 'plug device in after startup' ->
  stream-mock.emit \error code:\ENOENT
  clock.tick 5000ms
  run-activity 1 1

test 'unplug then replug device' ->
  run-activity 1 1
  stream-mock.emit \error code:\ENODEV
  clock.tick 5000ms
  run-activity 1 2

function run-activity val, expect-activity-count
  stream-mock.emit \data Buffer.allocUnsafe(24bytes).fill val
  A.equal expect-activity-count, activity-count
