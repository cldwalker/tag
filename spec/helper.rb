gem 'minitest' unless ENV['NO_RUBYGEMS']
require 'minitest/spec'
require 'minitest/autorun' unless $0.end_with?('/m')
require 'tag'
require 'fileutils'
require 'bahia'

ENV['TAG_HOME'] = File.dirname(__FILE__) + '/.tag'
ENV.delete('TAG_MODEL') # in case it's set

class MiniTest::Unit::TestCase
  include Bahia
end

MiniTest::Unit.after_tests { FileUtils.rm_rf(ENV['TAG_HOME']) }
