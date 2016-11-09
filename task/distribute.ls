Assert = require \assert
Shell  = require \shelljs/global
W4     = require \wait.for .for
Args   = require \./args
Dir    = require \./constants .dir

module.exports =
  prepare: ->
    if test \-e pjson = "#{Dir.BUILD}/package.json"
      cp \-f pjson, Dir.ROOT
      cp \-f pjson, Dir.build.APP
    cp \-f "#{Dir.ROOT}/readme.md" Dir.build.APP

  publish-local: ->
    throw new Error 'please specify local dir on command line' unless dest = Args.npm-local
    log "publish to local #dest"
    rm \-rf dest
    cp \-r "#{Dir.build.APP}/*" dest

  publish-public: ->
    pushd Dir.build.APP
    try
      W4 exec, 'npm publish' silent:false
    finally
      popd!
