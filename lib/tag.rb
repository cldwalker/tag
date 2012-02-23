require 'tag/runner'
require 'fileutils'
require 'tag/store'
require 'tag/version'

module Tag
  def self.store(model = nil)
    @store ||= Store.new(model)
  end

  def self.home
    @home ||= (ENV['TAG_HOME'] || File.join(Dir.home, '.tag')).tap do |dir|
      FileUtils.mkdir_p(dir)
    end
  end
end
