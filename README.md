# Data Structures and Algorithms

This repository contains my solutions to two projects from [The Odin Project](https://www.theodinproject.com).

## Binary Search Tree

The file `tree.rb` contains an implementation of a [Binary Search Tree](https://en.wikipedia.org/wiki/Binary_search_tree) that is initialized from an array. The constructed BST will initially be balanced.

The implementation provides the following public methods:

- `#insert(value)`: Adds a node with the provided `value` into the tree.
- `#find(value)`: Returns the node with the provided `value`, or `nil` if no such node exists in the tree.
- `#delete(value)`: Removes the node with the provided `value` from the tree, if it exists.
- `#balanced?`: Returns whether the tree is balanced; that is, whether the left subtree and right subtree differ in depth by no more than 1.
- `#rebalance!`: Rebalances the tree. 
- `#depth(node)`: Returns how many levels of nodes are beneath the given node in the tree.
- `#level_order`: Yields to a provided block on every node in the tree in  a level-order traversal. Returns an array of values in level-order if no block is provided.
- `#preorder`: Yields to a provided block on every node in the tree in a preorder traversal. Returns an array of values in preorder if no block is provided.
- `#inorder`: Yields to a provided block on every node in the tree in an inorder traversal. Returns an array of values in inorder if no block is provided.
- `#postorder`: Yields to a provided block on every node in the tree in a postorder traversal. Returns an array of values in postorder if no block is provided.

## Knights Travails

TODO: Implement and document.