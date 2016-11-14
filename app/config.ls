Fs   = require \fs
Lc   = require \leanconf
_    = require \lodash
Args = require \./args

var cache, fsw

module.exports = me =
  get : -> cache
  load: ->
    me.reset!
    path = Args.config-path
    try
      log.debug "load config from #path"
      conf = Fs.readFileSync path
    catch e
      return throw e unless e.code is \ENOENT
      log "Unable to find configuration file #path"
      unless Args.is-default-config-path
        log 'Please ensure this path is correct and the file exists.'
        return me
      log "Copying default config to #path"
      Fs.writeFileSync path, conf = Fs.readFileSync "#__dirname/default.conf"
    cfg = Lc.parse conf
    cache := {}
    for key, rule of cfg
      validate key, rule
      cache[key] = rule
    fsw := Fs.watch path, (ev, fname) ->
      return unless ev is \change
      log "Reload #path"
      me.load!
    me
  reset: -> # for tests
    fsw?close!
    cache := null

function validate key, rule
  unless _.startsWith key, \/dev/input
    throw new Error "Bad path #key must start with /dev/input/"
  unless \* is filter = (_.keys rule).0
    throw new Error "Bad rule filter at #key: #filter must be wildcard *"
  unless rule.'*'.run?
    throw new Error "Bad rule at #key: run command must be specified"
