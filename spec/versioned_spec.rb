require 'spec_helper'

describe 'rspec/versioned' do
  it 'can run a normal example' do
    expect(1).to eq 1
  end

  context 'without asking for URI' do
    before :all do
      @count = 1
    end

    it 'can run an example and get a version number', versions:{only:1} do |ex|
      expect(ex.version.number).to eq 1
    end

    it 'can run an example and get version numbers for a range of versions', versions:{to:3} do |ex|
      expect(ex.version.number).to eq(@count)
      @count += 1
    end
  end

  context 'after setting a URI' do
    before :all do
      @count = 1
      VersionedBlocks.base_uri = "http://api.com"
    end

    it 'can run an example and get a version number', versions:{only:1} do |ex|
      expect(ex.version.uri).to include ex.version.number.to_s
    end

    it 'can override base_uri', versions:{only:1, base_uri:'http://api2.com', override:true} do |ex|
      expect(ex.version.uri).to include 'http://api2.com'
    end

    it 'can run an example and get version numbers and URIs for a range of versions', versions:{to:3} do |ex|
      expect(ex.version.uri).to include('api.com')
      expect(ex.version.uri).to include(ex.version.number.to_s)
      expect(ex.version.number).to eq(@count)
      @count += 1
    end
  end

  context 'nested examples' do
    before :all do
      @outer_count = 1
      @always_1 = 1
    end

    context 'nested', versions:{from:2, to:4} do
      it 'runs the correct amount of times' do |ex|
        @outer_count += 1
        expect(@outer_count).to eq ex.version.number
      end

      it 'only runs once for this one', versions:{only:1} do
        expect(@always_1).to eq 1
        @always_1 += 1
      end

      context 'another nested' do
        before :all do
          @inner_count = 1
        end

        it 'runs the correct amount of times' do |ex|
          @inner_count += 1
          expect(@inner_count).to eq ex.version.number
        end
      end
    end
  end
end
