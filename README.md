# RSpec::Versioned

Inspired by [RSpec::Retry](https://github.com/y310/rspec-retry), Rspec::Versioned allows RSpec examples and example groups to easily be repeated over different API versions using the [versioned_blocks](https://github.com/devend711/versioned_blocks) gem.

	it 'tests multiple API versions', versions:{from:2, to:4} do |example|
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

See [versioned_blocks' documentation](https://github.com/devend711/versioned_blocks) for info about how to set a base URI and define ranges for the versions you want to test. Simply pass those options to an RSpec example group or a specific example, like this:

	it 'tests multiple API versions', versions:{from:2, to:4} do |example|
		...

	context 'when the API version is between 2 and 4', versions:{from:2, to:4} do
		it 'tests multiple API versions' do |example|
			...

	it 'tests a different base URI', versions:{only:1, base_uri:'http://www.api2.com'} do |example|
		...

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rspec-versioned/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
