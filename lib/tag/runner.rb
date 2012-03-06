require 'boson/runner'

module Tag
  class Runner < Boson::Runner
    def self.model_option
      option :model, :type => :string
    end

    model_option
    option :tags, :type => :array, :required => true
    desc 'add tag(s) to item(s)'
    def add(*items)
      options = items[-1].is_a?(Hash) ? items.pop : {}
      Tag.store(options[:model]).multi_tag(items, options[:tags])
    end

    model_option
    option :tags, :type => :array, :required => true
    desc 'remove tag(s) from item(s)'
    def rm(*items)
      options = items[-1].is_a?(Hash) ? items.pop : {}
      Tag.store(options[:model]).multi_remove_tag(items, options[:tags])
    end

    model_option
    desc 'list items by tag'
    def list(tag, options={})
      puts Tag.store(options[:model]).list(tag)
    end

    model_option
    option :rm, :type => :boolean, :desc => 'remove tags'
    desc 'list or remove tags'
    def tags(*args)
      options = args[-1].is_a?(Hash) ? args.pop : {}
      if options[:rm]
        Tag.store(options[:model]).delete_tags(*args)
      else
        puts Tag.store(options[:model]).list_tags
      end
    end

    model_option
    desc 'print tags with their items underneath them'
    def tree(options={})
      puts Tag.store(options[:model]).tree
    end

    desc 'list models'
    def models
      puts Tag::Store.models
    end
  end
end
