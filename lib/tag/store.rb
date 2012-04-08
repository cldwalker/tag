require 'yaml'

module Tag
  class Store

    def self.models
      Dir["#{Tag.home}/*.yml"].map {|file| file[%r{([^/]+).yml$}, 1] }.sort
    end

    def initialize(model = nil)
      model ||= ENV['TAG_MODEL'] || 'default'
      @file = File.join(Tag.home, "#{model}.yml")
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

    def items
      @hash.each_with_object({}) do |(tag,items),acc|
        items.each do |item|
          (acc[item] ||= []) << tag
        end
      end.sort_by {|e| e[0] }.map do |k,v|
        "#{k}\t#{v.uniq.join(', ')}"
      end
    end
  end
end
