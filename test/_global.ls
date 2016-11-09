global.log = console.log
global.log.debug = if 0 then console.log else ->
Error.stackTraceLimit = 3
