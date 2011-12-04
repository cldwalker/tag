require 'thor'

module Tag
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
