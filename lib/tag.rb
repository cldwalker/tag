require 'tag/store'
require 'tag/runner'

module Tag
  VERSION = '0.1.0'

  def self.store
    @store ||= Store.new
  end
end
