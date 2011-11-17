require 'yaml'
require 'thor'

module Tag
  VERSION = '0.1.0'

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

  def self.store
    @store ||= Store.new
  end

  class Runner < Thor
    method_option :tags, :type => :array, :required => true, :aliases => '-t'
    desc "add *ITEMS -t *TAGS", 'add tag(s) to item(s)'
    def add(*items)
      Tag.store.multi_tag(items, options[:tags])
    end

    method_option :tags, :type => :array, :required => true, :aliases => '-t'
    desc "rm *ITEMS -t *TAGS", 'remove tag(s) from item(s)'
    def rm(*items)
      Tag.store.multi_remove_tag(items, options[:tags])
    end

    desc "list TAG", 'list items by tag'
    def list(tag)
      puts Tag.store.list(tag)
    end

    method_option :rm, :type => :boolean, :desc => 'remove tags'
    desc "tags", 'list or remove tags'
    def tags(*args)
      if options[:rm]
        Tag.store.delete_tags(*args)
      else
        puts Tag.store.list_tags
      end
    end

    desc "tree", 'print tags with their items underneath them'
    def tree
      puts Tag.store.tree
    end
  end
end
