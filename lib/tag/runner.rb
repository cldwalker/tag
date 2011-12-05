require 'thor'

module Tag
  class Runner < Thor
    def self.model_option
      method_option :model, :type => :string, :aliases => '-m'
    end

    model_option
    method_option :tags, :type => :array, :required => true, :aliases => '-t'
    desc "add *ITEMS -t *TAGS", 'add tag(s) to item(s)'
    def add(*items)
      Tag.store(options[:model]).multi_tag(items, options[:tags])
    end

    model_option
    method_option :tags, :type => :array, :required => true, :aliases => '-t'
    desc "rm *ITEMS -t *TAGS", 'remove tag(s) from item(s)'
    def rm(*items)
      Tag.store(options[:model]).multi_remove_tag(items, options[:tags])
    end

    model_option
    desc "list TAG", 'list items by tag'
    def list(tag)
      puts Tag.store(options[:model]).list(tag)
    end

    model_option
    method_option :rm, :type => :boolean, :desc => 'remove tags'
    desc "tags", 'list or remove tags'
    def tags(*args)
      if options[:rm]
        Tag.store(options[:model]).delete_tags(*args)
      else
        puts Tag.store(options[:model]).list_tags
      end
    end

    model_option
    desc "tree", 'print tags with their items underneath them'
    def tree
      puts Tag.store(options[:model]).tree
    end
  end
end
