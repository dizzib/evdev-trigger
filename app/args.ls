C = require \commander
P = require \path
J = require \./package.json

default-config-home = process.env.XDG_CONFIG_HOME or P.join process.env.HOME, \.config
default-config-path = "#default-config-home/evdev-trigger.conf"

C.version J.version
C.usage '[Options]'
C.option '-c, --config-path [path]' "path to configuration file (default:#default-config-path)" default-config-path
C.option '-d, --dry-run' 'bypass command execute'
C.option '-v, --verbose' 'emit detailed trace for debugging'
C.parse process.argv
C.is-default-config-path = C.config-path is default-config-path

module.exports = C
