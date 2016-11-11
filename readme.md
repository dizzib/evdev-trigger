# evdev-trigger
[![Build Status](https://travis-ci.org/dizzib/evdev-trigger.svg?branch=master)](https://travis-ci.org/dizzib/evdev-trigger)

* run shell commands when [evdev] input focus changes.

I use this to auto-disable [mousetweaks] when I'm using my touchscreen
monitor, and auto-enable mousetweaks when I switch to my touchpad.
This prevents unnecessary auto-clicks when tapping my touchscreen monitor.

## install globally and run

With [node.js] installed on the target [X11] box:

    $ npm install -g evdev-trigger            # might need to prefix with sudo
    $ evdev-trigger

To read from `/dev/input/` the running user needs to be a member of the *input* group.

## configure

On its first run evdev-trigger copies the [default configuration file] to
`$XDG_CONFIG_HOME/evdev-trigger.conf` which [defaults to][$XDG_CONFIG_HOME]
`$HOME/.config/evdev-trigger.conf`. Edit this [leanconf] file with one or more
rules:

    /dev/input/path:                # for example /dev/input/event0
      *:                            # event filter, wildcard * matches all events
        run: shell-command-to-run

The following example configuration file enables or disables [mousetweaks]
depending on which input device is currently in use:

    # evdev-trigger.conf example configuration

    /dev/input/by-id/usb-PixArtImaging_OpticalTouchScreen_0000-event-if00:
      *:
        run: mousetweaks --shutdown

    /dev/input/by-id/usb-Wacom_Co._Ltd._Intuos_PTS-if01-event-mouse:
      *:
        run: mousetweaks --dwell --daemonize

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
[mousetweaks]: https://help.gnome.org/users/mousetweaks/stable/mouse-a11y-introduction.html.en
[node.js]: http://nodejs.org
[JavaScript regular expression]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
[X11]: https://en.wikipedia.org/wiki/X_Window_System
