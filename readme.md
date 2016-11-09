# evdev-trigger
[![Build Status](https://travis-ci.org/dizzib/evdev-trigger.svg?branch=master)](https://travis-ci.org/dizzib/evdev-trigger)

* run shell commands whenever [evdev] activity switches to a different device.

I use this to temporarily auto-disable mousetweaks when I'm using my touch-screen
monitor, then auto-enable mousetweaks when I switch back to my touchpad.

## install globally and run

With [node.js] installed on the target [X11] box:

    $ npm install -g evdev-trigger            # might need to prefix with sudo
    $ evdev-trigger

## configure

On its first run evdev-trigger copies the [default configuration file] to
`$XDG_CONFIG_HOME/evdev-trigger.conf` which [defaults to][$XDG_CONFIG_HOME]
`$HOME/.config/evdev-trigger.conf`. Edit this [leanconf] file with one or more rules:


## options

    $ evdev-trigger --help
    Usage: evdev-trigger [Options]

    Options:

      -h, --help                output usage information
      -V, --version             output the version number
      -c, --config-path [path]  path to configuration file (default:~/.config/evdev-trigger.conf)
      -d, --dry-run             trace commands without executing
      -v, --verbose             emit detailed trace for debugging

## developer build and run

    $ git clone --branch=dev https://github.com/dizzib/evdev-trigger.git
    $ cd evdev-trigger
    $ npm install     # install dependencies
    $ npm test        # build all and run tests
    $ npm start       # start the task runner and dry-run evdev-trigger

## license

[MIT](./LICENSE)

[$XDG_CONFIG_HOME]: http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
[default configuration file]: ./app/default.conf
[evdev]: https://en.wikipedia.org/wiki/Evdev
[leanconf]: https://github.com/dizzib/leanconf
[node.js]: http://nodejs.org
[JavaScript regular expression]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
[X11]: https://en.wikipedia.org/wiki/X_Window_System
