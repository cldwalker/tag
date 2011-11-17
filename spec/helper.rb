gem 'minitest' unless ENV['NO_RUBYGEMS']
require 'minitest/autorun'
require 'tag'
require 'open3'
require 'fileutils'

ENV['TAGRC'] = File.dirname(__FILE__) + '/.tagrc'

module TestHelpers
  attr_reader :stdout, :stderr, :process

  def tag(cmd)
    args = cmd.split(/\s+/)
    args.unshift File.dirname(__FILE__) + '/../bin/tag'
    args.unshift({'RUBYLIB' => "#{File.dirname(__FILE__)}/../lib:" +
                 ENV['RUBYLIB']})
    @stdout, @stderr, @process = Open3.capture3(*args)
  end
end

class MiniTest::Unit::TestCase
  include TestHelpers
end

MiniTest::Unit.after_tests { FileUtils.rm_f(ENV['TAGRC']) }
