gem 'minitest' unless ENV['NO_RUBYGEMS']
require 'minitest/autorun'
require 'tag'
require 'fileutils'
require 'bahia'

ENV['TAG_HOME'] = File.dirname(__FILE__) + '/.tag'

class MiniTest::Unit::TestCase
  include Bahia
end

MiniTest::Unit.after_tests { FileUtils.rm_rf(ENV['TAG_HOME']) }
