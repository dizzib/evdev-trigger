Ev = require \events
Fs = require \fs
_  = require \lodash

module.exports = class extends Ev.EventEmitter
  (@path, @rule) ->
    start-reading!

    ~function start-reading
      s = Fs.createReadStream @path, flags:\r encoding:null
      s.enoerr-count = 0 # multiple errors should only cause 1 retry
      s.on \data ~>
        const CHUNK-LENGTH = 8 + 8 + 2 + 2 + 4
        for i from 0 to it.length by CHUNK-LENGTH
          continue unless (chunk = it.slice(i, i+CHUNK-LENGTH)).length is CHUNK-LENGTH
          type = chunk.readUInt16LE 16
          code = chunk.readUInt16LE 18
          value = chunk.readUInt32LE 20
          continue unless type + code + value
          #log @path, type, code, value
          @emit \activity
      s.on \error ~>
        log "#it (at #{@path})"
        return unless it.code in <[ ENOENT ENODEV ]> and 1 is s.enoerr-count += 1
        setTimeout start-reading, 5000ms # keep retrying until the device shows up
