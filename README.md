# RSpec::Versioned

[![Gem Version](https://badge.fury.io/rb/rspec-versioned.svg)](http://badge.fury.io/rb/rspec-versioned)

Inspired by [RSpec::Retry](https://github.com/y310/rspec-retry), Rspec::Versioned allows RSpec examples and example groups to easily be repeated over different API versions using the [versioned_blocks](https://github.com/devend711/versioned_blocks) gem. Just add the `:versions` option to an example:

	VersionedBlocks.base_uri = 'http://www.api.com'

	it 'tests multiple API versions', versions:{from:2, to:4} do |example|
       expect(example.version.uri).to include example.version.number.to_s
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

	VersionedBlocks.base_uri = 'http://www.api.com'

	it 'tests multiple API versions', versions:{to:3} do |example|
		...

	context 'when the API version is between 2 and 4', versions:{from:2, to:4} do
		it 'tests multiple API versions' do |example|
			...

	it 'tests a different base URI', versions:{only:1, base_uri:'http://www.api2.com', override:true} do |example|
		...

Examples returned from the block will respond to `version.number` and a `version.uri` where `version.uri` will be the string `"#{VersionedBlocks.base_uri}/v#{version.number}"`

Rspec::Versioned can add the version it's currently testing to RSpec's output messages. Just add this line to your RSpec config:

	config.notify_version_number = true

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rspec-versioned/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### To do

- Provide current version info in before/after hooks
