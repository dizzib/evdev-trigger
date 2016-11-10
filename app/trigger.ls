Cp   = require \child_process
Args = require \./args
Log  = require \./log # setup global log first
Cfg  = require \./config .load!
Dev  = require \./device

return log 'No configuration -- bailing' unless cfg = Cfg.get!
log.debug 'Load configuration:' cfg

var last-active-dev
devs = [(new Dev path, rule).on \activity handler for path, rule of cfg]

function handler
  return if this is last-active-dev
  run-command @rule.'*'.run
  last-active-dev := this

function run-command
  return log "dry-run #it" if Args.dry-run
  log.debug it
  err, stdout, stderr <- Cp.exec it
  return log err if err
  log stdout if stdout.length
  log stderr if stderr.length
