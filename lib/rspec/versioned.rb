require "rspec/versioned/version"
require 'rspec/core'
require 'rspec_ext/rspec_ext'
require 'versioned_blocks'

module RSpec
  class Versioned
    def self.apply
      RSpec.configure do |config|
        config.add_setting :notify_version_number, :default => false
        config.add_setting :clear_lets_on_failure, :default => true

        fetch_current_example = RSpec.respond_to?(:current_example) ?
          proc { RSpec.current_example } : proc { |context| context.example }

        config.around(:each) do |ex| # ex is a Procsy
          notify_version_number = ex.metadata[:notify_version_number] || RSpec.configuration.notify_version_number

          example = fetch_current_example.call(self)
          example.new_version_info

          if ex.metadata.has_key?(:versions)
            if ex.metadata[:versions][:base_uri] || (VersionedBlocks.base_uri && VersionedBlocks.base_uri!='') # we have a URI
              versioned_block(ex.metadata[:versions]) do |v, uri|
                example.clear_exception
                example.version.set(v, uri)
                ex.run
                RSpec.configuration.reporter.message("RSpec::Versioned testing /v#{v}") if notify_version_number
              end
            else # we don't have a URI
              versioned_block(ex.metadata[:versions]) do |v|
                example.clear_exception
                example.version.set(v)
                ex.run
                RSpec.configuration.reporter.message("RSpec::Versioned testing /v#{v}") if notify_version_number
              end
            end
          else # didn't specify any versions...just run the test!
            ex.run
          end
          self.clear_lets if clear_lets
        end
      end
    end
  end
end

module HasVersionInfo
  def new_version_info
    @version_info = VersionInfoHolder.new
  end

  def version
    @version_info
  end

  def clear_exception
    @exception = nil
  end
end

module RSpec
  module Core
    class Example
      @version_info

      include HasVersionInfo

      class Procsy
        @version_info

        include HasVersionInfo
      end
    end
  end
end

class VersionInfoHolder
  attr_reader :number

  def uri
    return @uri if !@uri.nil?
    raise VersionedBlocksException, "Undefined URI!"
  end

  def set(v_number, uri=nil)
    @number = v_number
    @uri = uri
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