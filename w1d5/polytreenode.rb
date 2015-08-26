require "colorize"
require 'byebug'

class PolyTreeNode
  attr_accessor :value, :children
  attr_reader :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent_node)
    if parent_node.nil?
      @parent.children.delete(self)
      @parent = parent_node
    else
      @parent.children.delete(self) unless @parent.nil?
      @parent = parent_node
      @parent.children << self unless @parent.children.include?(self)
    end
  end


  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    child_node.parent = nil
  end

  def trace_path_back
    return [value] if @parent == nil
    path = []
    path.concat(@parent.trace_path_back)
    path << (value)
  end

  def dfs(target_value)
    return self if self.value == target_value
    children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    nodes = []
    nodes << self
    until nodes.empty?
      current = nodes.shift
      return current if current.value == target_value
      nodes.concat(current.children)
    end
    nil
  end

end


# n1 = PolyTreeNode.new("root1")
# n2 = PolyTreeNode.new("root2")
# n3 = PolyTreeNode.new("root3")
#
# # connect n3 to n1
# n3.parent = n1
# # connect n3 to n2
# n3.parent = n2
#
# # this should work
# raise "Bad parent=!" unless n3.parent == n2
# raise "Bad parent=!" unless n2.children == [n3]
#
# # this probably doesn't
# #raise "Bad parent=!" unless n1.children == []
