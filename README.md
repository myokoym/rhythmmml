# Rhythmmml [![Gem Version](https://badge.fury.io/rb/rhythmml.svg)](http://badge.fury.io/rb/rhythmml)

A rhythm game for MML (Music Macro Language) by Gosu with Ruby.

## Dependencies

* [Gosu](https://www.libgosu.org/)
* [mml2wav](https://github.com/myokoym/mml2wav)
  * [jstrait/wavefile](https://github.com/jstrait/wavefile)

## Installation

    $ gem install rhythmmml

## Usage

    $ rhythmmml XXX.mml

Or

    $ echo 'MML TEXT' | rhythmmml

## Example

    $ echo 't100 cdercdergedcdedr' | rhythmmml

## License

MIT License. See LICENSE.txt for details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
