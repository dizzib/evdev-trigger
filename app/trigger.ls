Cp   = require \child_process
U    = require \util
Log  = require \./log
Args = require \./args
Cfg  = require \./config .load!

return Log 'No configuration -- bailing' unless Cfg.get!
