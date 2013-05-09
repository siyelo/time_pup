# TimePup

A simple natural language date time parser extracted from [hound.cc](http://www.hound.cc). It is perfect for parsing the local part of an email address.

## Installation

Add this line to your application's Gemfile:

    gem 'time_pup'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install time_pup

## Usage

    TimePup.parse( 'tomorrow', timezone = UTC )

  The time is always returned in UTC, it is just adjusted based on the time zone provided e.g:

* TimePup.parse( '8am' ) #=> 8 AM UTC
* TimePup.parse( '8am', 'Harare' ) #=> 6 AM UTC

### Examples

**From now**

 > 2minutes <br/>
 > 3hours <br/>
 > 1day <br/>
 > 2weeks <br/>
 > 3month <br/>

**Composite**

 > 1day2hours <br/>

**Weekdays**

 > friday <br/>
 > monday9a <br/>
 > nexttuesda <br/>
 > nextweek <br/>

**Handy**

 > tomorrow <br/>
 > tomorrow1030am <br/>
 > endofday <br/>

**Actual Date**

 > 04july <br/>
 > aug-10 <br/>
 > 16sept1030am <br/>

**Actual Time**

 > 1030 <br/>
 > 22 <br/>
 > 1030am <br/>

**Abbreviations**

 > 2m <br/>
 > 5d <br/>
 > 1mo <br/>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
