require 'yaml'

module Tag
  class Store
    class << self; attr_accessor :file; end
    self.file = ENV['TAGRC'] || Dir.home + '/.tagrc'

    def initialize
      @file = self.class.file
      @hash = File.exists?(@file) ? YAML.load_file(@file) : {}
    end

    def save
      File.open(@file, 'w') {|f| f.write(@hash.to_yaml) }
    end

    def tag(item, tag)
      @hash[tag] ||= []
      @hash[tag] << item
    end

    def multi_tag(items, tags)
      tags.each do |tag|
        items.each do |item|
          tag(item, tag)
        end
      end
      save
    end

    def multi_remove_tag(items, tags)
      tags.each do |tag|
        items.each do |item|
          remove_tag(item, tag)
        end
      end
      save
    end

    def remove_tag(item, tag)
      @hash[tag] ||= []
      @hash[tag].delete item
    end

    def list(tag)
      @hash[tag] ||= []
      @hash[tag]
    end

    def list_tags
      @hash.keys.sort
    end

    def tree
      list_tags.map {|tag|
        ["#{tag}", list(tag).map {|t| "    #{t}" }]
      }.flatten
    end

    def delete_tags(*tags)
      tags.each {|tag| @hash.delete(tag) }
      save
    end
  end
end
