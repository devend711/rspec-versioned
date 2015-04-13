require "rspec/versioned/version"
require 'rspec/core'
require 'versioned_blocks'

module RSpec
  class Versioned
    def self.apply
      RSpec.configure do |config|
        config.add_setting :notify_version_number, :default => false
        config.add_setting :clear_lets_on_failure, :default => true

        fetch_current_example = RSpec.respond_to?(:current_example) ?
          proc { RSpec.current_example } : proc { |context| context.example }

        config.around(:each) do |p| # example is a Proc extended with Procsy
          notify_version_number = p.metadata[:notify_version_number] || RSpec.configuration.notify_version_number

          run_example = Proc.new do |v, uri|
            current_example = fetch_current_example.call(self)
            current_example.clear_exceptions
            p.metadata[:versioned] = {number:v, uri:uri}
            p.run
            RSpec.configuration.reporter.message("RSpec::Versioned testing /v#{v}") if notify_version_number
          end

          if p.metadata.has_key?(:versions)
            if p.metadata[:versions][:base_uri] || (VersionedBlocks.base_uri && VersionedBlocks.base_uri!='') # we have a URI
              versioned_block(p.metadata[:versions]) do |v, uri|
                run_example.call v,uri
              end
            else # we don't have a URI
              versioned_block(p.metadata[:versions]) do |v|
                run_example.call v
              end
            end
          else # didn't specify any versions...just run the test!
            p.run
          end
          self.clear_lets if clear_lets
        end
      end
    end
  end
end

module RSpec
  module Core
    class Example
      def clear_exceptions
        @exceptions = nil
      end

      def version
        @metadata[:versioned]
      end

      def clear_exceptions
        @exceptions = nil
      end
    end
  end
end

module RSpec
  module Core
    class ExampleGroup
      def clear_lets
        @__memoized = {}
      end
    end
  end
end

RSpec::Versioned.apply