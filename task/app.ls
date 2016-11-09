_     = require \lodash
Chalk = require \chalk
Cp    = require \child_process
Shell = require \shelljs/global
Args  = require \./args
Const = require \./constants
G     = require \./growl

const RUNCMD = 'trigger -d'

module.exports = me =
  recycle: ->
    err <- me.stop
    log err if err
    err <- me.start
    log err if err
  start: (cb) ->
    const RX-ERR = /(expected|error|exception)/i
    v = exec 'node --version', silent:true .output.replace '\n' ''
    cwd = Const.dir.build.APP
    log "start app in node #v: #RUNCMD"
    return cb new Error "unable to start non-existent app at #cwd" unless test \-e cwd
    Cp.spawn \node, (RUNCMD.split ' '), cwd:cwd, env:env <<< NODE_ENV:\development
      ..stderr.on \data ->
        log-data s = it.toString!
        # data may be fragmented, so only growl relevant packet
        if RX-ERR.test s then G.alert "#{Const.APPNAME}\n#s" nolog:true
      ..stdout.on \data ->
        log-data it.toString!
        cb! if /listening on port/.test it
  stop: (cb) ->
    log "stop app: #RUNCMD"
    kill-node RUNCMD, cb

function kill-node args, cb
  # can't use WaitFor as we need the return code
  code, out <- exec cmd = "pkill -ef 'node #{args.replace /\*/g, '\\*'}'"
  # 0 One or more processes matched the criteria.
  # 1 No processes matched.
  # 2 Syntax error in the command line.
  # 3 Fatal error: out of memory etc.
  return cb new Error "#cmd returned #code" if code > 1
  cb!

function log-data
  log Chalk.gray "#{Chalk.underline Const.APPNAME} #{it.slice 0, -1}"
