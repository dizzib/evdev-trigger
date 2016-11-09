C = require \commander

C.option '--npm-local [dir]' 'local publish directory'
C.parse process.argv
C.app-dirs = C.args

module.exports = C
