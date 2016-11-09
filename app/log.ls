module.exports = me = global.log = log
me.debug = if (require \./args).verbose then log else ->

function log ...args
  d = new Date Date.now!
  t = "#{d.getDate!}/#{1 + d.getMonth!} #{d.toLocaleTimeString!}"
  console.log t, ...args
