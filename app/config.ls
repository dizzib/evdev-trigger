A    = require \assert
Fs   = require \fs
Lc   = require \leanconf
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
    for k, v of cfg
      cache[k] = v
    fsw := Fs.watch path, (ev, fname) ->
      return unless ev is \change
      log "Reload #path"
      me.load!
    me
  reset: -> # for tests
    fsw?close!
    cache := null
