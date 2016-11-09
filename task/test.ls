_     = require \lodash
Cp    = require \child_process
Shell = require \shelljs/global
Dir   = require \./constants .dir
G     = require \./growl

const DIRBIN = "#{Dir.ROOT}/node_modules/.bin"
const ISTANB = "#DIRBIN/istanbul"
const I-ARGS = "cover #DIRBIN/_mocha"
const M-ARGS = '--reporter spec --bail --colors test/**/*.js'

module.exports =
  exec: ->
    exec "#ISTANB #I-ARGS -- --timeout 5000 #M-ARGS"
  run: (cb) ->
    v = exec 'node --version' silent:true .output - '\n'
    log "run tests in node #v"
    args = "#I-ARGS -- #M-ARGS" / ' '
    output = ''
    Cp.spawn ISTANB, args, cwd:Dir.BUILD, stdio:[ 0, void, 2 ]
      ..on \exit ->
        tail = output.slice -750
        G.ok "All tests passed\n\n#tail" nolog:true unless it
        G.alert "Tests failed (code=#it)\n\n#tail" nolog:true if it
        return unless _.isFunction cb
        cb if it then new Error "Exited with code #it" else void
      ..stdout.on \data ->
        process.stdout.write it
        output += it.toString!
