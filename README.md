# RSpec::Versioned

Inspired by [RSpec::Retry|https://github.com/y310/rspec-retry], Rspec::Versioned allows RSpec examples and example groups to easily be repeated over different API versions using the [versioned_blocks|https://github.com/devend711/versioned_blocks] gem.

	it 'tests multiple API versions', versions:{to:3} do |example|
      expect(example.version.number).to be > 0
      expect(example.version.uri).to include 'http://www.api.com'
    end

## Installation

Add this line to your application's Gemfile:

    gem 'rspec-versioned'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-versioned

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rspec-versioned/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
