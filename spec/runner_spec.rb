require File.expand_path(File.dirname(__FILE__) + '/helper')

describe Tag::Runner do
  def tagged(tag)
    tag "list #{tag}"
    stdout.split("\n")
  end

  before { FileUtils.rm_f(ENV['TAGRC']) }

  describe "add" do
    it "adds a tag" do
      tag 'add feynman -t physicist'
      tagged('physicist').must_equal ["feynman"]
    end

    it "adds two tags" do
      tag 'add feynman -t physicist teacher'
      tagged('physicist').must_equal ["feynman"]
      tagged('physicist').must_equal ["feynman"]
    end

    it "adds a tag to two items" do
      tag 'add feynman fermi -t physicist'
      tagged('physicist').must_equal %w{feynman fermi}
    end

    it "fails if no tag given" do
      tag 'add um'
      stderr.must_include 'required option'
    end
  end

  describe "rm" do
    it "removes a tag" do
      tag 'add newton -t physicist fig'
      tag 'rm newton -t fig'
      tagged('physicist').must_equal ['newton']
      tagged('fig').must_equal []
    end

    it "removes two tags" do
      tag 'add newton -t physicist fig sir'
      tag 'rm newton -t fig sir'
      tagged('physicist').must_equal ['newton']
      tagged('fig').must_equal []
      tagged('sir').must_equal []
    end

    it "removes two items from a tag" do
      tag 'add newton -t physicist fig'
      tag 'add tree -t fig'
      tag 'rm newton tree -t fig'
      tagged('fig').must_equal []
    end

    it "fails if no tag given" do
      tag 'rm um'
      stderr.must_include 'required option'
    end
  end

  describe "tags" do
    it "by default lists all tags" do
      tag 'add fermi -t italian german irish'
      tag 'tags'
      stdout.split("\n").must_equal %w{german irish italian}
    end

    it "with rm option delets tags" do
      tag 'add fermi -t italian german irish'
      tag 'add davinci -t italian german irish'
      tag 'tags german irish --rm'
      tagged('german').must_equal []
      tagged('irish').must_equal []
    end
  end

  it "tree prints tree" do
    tag 'add child -t parent1 parent2'
    tag 'tree'
    stdout.chomp.must_equal [
      'parent1', '    child', 'parent2', '    child'
    ].join("\n")
  end
end
