# frozen_string_literal: true

require_relative 'node'

## For the tree to be balanced, we want to insert from the middle, then the middles of the two halves, etc.
class Tree
  attr_accessor :root
  def initialize(arr)
    @root = build_tree(arr)
  end

  def level_order
    queue = []
    values = []
    queue.push(@root)
    until queue.empty?
      current = queue.shift
      yield(current) if block_given?
      values << current.value unless block_given?
      queue.push(current.left) unless current.left.nil?
      queue.push(current.right) unless current.right.nil?
    end

    return values unless block_given?
  end

  def inorder(iter = @root, values = [], &block)
    if iter.nil?
      return if block_given?

      return values
    end

    inorder(iter.left, values, &block)
    block.call(iter) if block_given?
    values << iter.value unless block_given?
    inorder(iter.right, values, &block)
    return values unless block_given?
  end

  def preorder(iter = @root, values = [], &block)
    if iter.nil?
      return if block_given?

      return values
    end

    block.call(iter) if block_given?
    values << iter.value unless block_given?
    preorder(iter.left, values, &block)
    preorder(iter.right, values, &block)
    return values unless block_given?
  end

  def postorder(iter = @root, values = [], &block)
    if iter.nil?
      return if block_given?

      return values
    end
    postorder(iter.left, values, &block)
    postorder(iter.right, values, &block)
    block.call(iter) if block_given?
    values << iter.value unless block_given?
    return values unless block_given?
  end

  def depth(node)
    return 0 if node.nil? || (node.left.nil? && node.right.nil?)

    depth_below = [depth(node.left), depth(node.right)].max
    depth_below + 1
  end

  def balanced?
    return true if @root.nil?

    left_depth = depth(@root.left)
    right_depth = depth(@root.right)
    max = [left_depth, right_depth].max
    min = [left_depth, right_depth].min
    max - min < 2
  end

  def rebalance!
    arr = []
    level_order do |node|
      arr << node.value
    end
    arr.sort!
    @root = build_tree(arr)
  end

  def insert(value, iter = @root)
    if iter.nil?
      node = Node.new(value)
      if iter == @root
        @root = node
        return @root
      end
      return node
    end

    if value < iter.value
      iter.left = insert(value, iter.left)
    elsif value > iter.value
      iter.right = insert(value, iter.right)
    end
    iter
  end

  def find(value, iter = @root)
    return nil if iter.nil?
    return iter if iter.value == value
    return find(value, iter.left) if value < iter.value

    find(value, iter.right)
  end

  def delete(value, iter = @root)
    return nil if iter.nil?

    if value < iter.value
      iter.left = delete(value, iter.left)
      return
    elsif value > iter.value
      iter.right = delete(value, iter.right)
      return
    end

    if iter.right.nil?
      return iter.left
    elsif iter.left.nil?
      return iter.right
    elsif iter.right.left.nil?
      iter.right.left = iter.left
      return iter.right
    end

    trailing = iter.right
    leftmost_on_right_side = iter.right.left

    until leftmost_on_right_side.left.nil?
      trailing = trailing.left
      leftmost_on_right_side = leftmost_on_right_side.left
    end

    trailing.left = leftmost_on_right_side.right
    leftmost_on_right_side.left = iter.left
    leftmost_on_right_side.right = iter.right

    @root = leftmost_on_right_side if iter == @root
    leftmost_on_right_side
  end

  private

  def build_tree(arr)
    build_tree_rec(arr.sort.uniq)
  end

  def build_tree_rec(sorted_arr)
    return nil if sorted_arr.empty?

    mid = sorted_arr.length / 2
    node = Node.new(sorted_arr[mid])
    sorted_left = sorted_arr.slice!(0...mid)
    sorted_right = sorted_arr.slice!(1..-1)
    node.left = build_tree_rec(sorted_left)
    node.right = build_tree_rec(sorted_right)
    node
  end

  def level_order_rec(level = [@root], values = [], &block)
    if level.empty?
      return if block_given?

      return values
    end

    values += level.map(&:value) unless block_given?

    next_level = []
    level.each do |node|
      next if node.nil?

      block.call(node) if block_given?
      next_level.push(node.left)
      next_level.push(node.right)
    end
    level_order_rec(next_level, values, &block)
  end
end
