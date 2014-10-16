require 'pathname'
require 'minitest/autorun'
require 'rack'
begin
  require 'ruby-debug'
  require 'phocus'
  require 'redgreen'
rescue LoadError, RuntimeError
end

root = Pathname(__FILE__).dirname.parent.expand_path
$:.unshift(root.join('lib'))

require 'rack/respond_to'

class MiniTest::Unit::TestCase
  def self.test(name, &block)
    define_method(:"test_#{name.gsub(/\s/,'_')}", &block)
  end
end
