require 'rspec'
require_relative '../lib/fbcifs/operator'
require_relative '../lib/fbcifs/commands/commands'
require_relative '../lib/fbcifs/uri_parser'
require_relative '../lib/fbcifs/config'

describe Fbcifs::Credentials, '#authfile' do
  it "should return a pseudorandom hash for authfile name" do
    expect(Fbcifs::Credentials.new('login','password').authfile).to match /tmp\/.{32}\.pwd/
  end
end
