require 'tag/runner'
require 'fileutils'
require 'tag/store'

module Tag
  VERSION = '0.2.0'

  def self.store(model = nil)
    @store ||= Store.new(model)
  end

  def self.home
    @home ||= (ENV['TAG_HOME'] || File.join(Dir.home, '.tag')).tap do |dir|
      FileUtils.mkdir_p(dir)
    end
  end
end
