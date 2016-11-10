Ev = require \events
Fs = require \fs

module.exports = class extends Ev.EventEmitter
  (@path, @rule) ->
    s = Fs.createReadStream @path, flags:\r encoding:null
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
      log 'Error %s - When reading %s', it, @path
