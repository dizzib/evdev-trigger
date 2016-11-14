test = it
<- describe 'device'

A = require \chai .assert
E = require \events
M = require \mockery

var T, activity-count
stream-mock = new E.EventEmitter
fs-mock = createReadStream: -> stream-mock

after ->
  M.deregisterAll!
  M.disable!
before ->
  M.enable warnOnUnregistered:false
beforeEach ->
  M.registerMock \fs fs-mock
  activity-count := 0
  T := new (require \../app/device) \/path/0 '*':run:\command
    .on \activity -> activity-count += 1

test 'valid chunk should raise activity event' -> run-activity 1 1
test 'separator chunk should not raise activity event' -> run-activity 0 0

function run-activity val, expect-activity-count
  stream-mock.emit \data Buffer.allocUnsafe(24).fill val
  A.equal expect-activity-count, activity-count
