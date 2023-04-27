// A binary search tree (BST) imposes two rules on the binary tree
// 1- The value of a left child must be less than the value of its parent
// 2- The value of a right child must be greater than or equal to
// the value of its parent
//
// Lookup, insert and removal have an average time complexity of O(log n), which
// is faster than linear data structures such as lists and linked lists.
//
// Balanced vs. Unbalanced Trees:
// * A balanced tree is a tree in which the heights of the left and right
//   subtrees of every node differ by at most one.
// * An unbalanced tree is a tree in which the heights of the left and right
//   subtrees of some nodes differ significantly.
// An unbalanced tree effects performance (it may ends to O(n) in some
// situations)
// You can create structures known as self-balanced trees which is called as
// AVL Trees.

import 'package:dsa/binary_node.dart';

/// by definition, binary search trees can only hold values that are Comparable.
///
/// We could use [Comparable<E>] instead of [Comparable<dynamic>]. However [int]
/// doesn't directly implement [Comparable]; its superclass [num] does.
/// That makes it so that users of your class whould have to use [num] when they
/// really want [int]. Using [Comparable<dynamic>], on the other hand, allows
/// them to use [int] directly.
class BinarySearchTree<E extends Comparable<dynamic>> {
  BinaryNode<E>? root;

  void insert(E value) {
    root = _insertAt(root, value);
  }

  // This is a recursive method.
  BinaryNode<E> _insertAt(BinaryNode<E>? node, E value) {
    // if node is [null], we have found the insertion point and return the
    // new [BinaryNode].
    if (node == null) return BinaryNode(value);

    // This [if] statement controls which way the next [_insertAt] call should
    // traverse
    if (value.compareTo(node.value) < 0) {
      node.leftChild = _insertAt(node.leftChild, value);
    } else {
      node.rightChild = _insertAt(node.rightChild, value);
    }

    // This makes assignments of the form [node = _insertAt(node, value)]
    // possible as _insertAt will either create node, if it was null, or return
    // node, if it was not null.
    return node;
  }

  bool contains(E value) {
    var current = root;
    while (current != null) {
      if (current.value == value) return true;
      if (value.compareTo(current.value) < 0) {
        current = current.leftChild;
      } else {
        current = current.rightChild;
      }
    }
    return false;
  }

  /// - Removing a leaf node is straightforward. Simply detach the leaf node.
  /// - When removing node with *one* child, We'll need to reconnect that child
  ///   with the rest of the tree (aka to elder parent)
  /// - To removing nodes with *two* children, we'll implement a clever
  ///   workaround by performing a swap. when removing a node with two children,
  ///   replacing the node we removed with the smallest node in the right
  ///   subtree. Based on the principles of BST, this is the leftmost node of
  ///   the right subtree.
  void remove(E value) {
    root = _remove(root, value);
  }

  BinaryNode<E>? _remove(BinaryNode<E>? node, value) {
    if (node == null) return null;
    if (value == node.value) {
      /// - Remove leaf node by returning null, thereby removing the current node
      if (node.leftChild == null && node.rightChild == null) {
        return null;
      }

      /// - Removing node with one child
      /// If the node has no left child, we return [node.rightChild] to
      /// reconnect the right subtree.
      /// If the node has no right child, we return [node.leftChild] to
      /// reconnect the left subtree.
      if (node.leftChild == null) return node.rightChild;
      if (node.rightChild == null) return node.leftChild;

      /// - Removing node with two children
      /// We replace the node's value with the smallest value from the right
      /// subtree, the call remove on the right child to remove this swapped
      /// value.
      node.value = node.rightChild!.min.value;
      node.rightChild = _remove(node.rightChild, node.value);
    } else if (value.compareTo(node.value) < 0) {
      node.leftChild = _remove(node.leftChild, value);
    } else {
      node.rightChild = _remove(node.rightChild, value);
    }
    return node;
  }

  @override
  String toString() => root.toString();
}

extension _MinFinder<E> on BinaryNode<E> {
  /// To find the minimum value in a BST, we just need to find the leftmost node
  /// in the tree.
  BinaryNode<E> get min => leftChild?.min ?? this;
}

extension TreeEquality on BinarySearchTree {
  /// Check if the current tree is equal to another BST tree.
  /// ``` dart
  /// tree.isEqualTo(anotherBSTTree)
  /// ```
  bool isEqualTo(BinarySearchTree other) {
    return _isEqualTo(root, other.root);
  }

  bool _isEqualTo(BinaryNode? first, BinaryNode? second) {
    if (first == null || second == null) return first == null && second == null;
    // We check the value of first and the second nodes for equality. We also
    // recursively check the left children and the right children for equality.
    return first.value == second.value &&
        _isEqualTo(first.leftChild, second.leftChild) &&
        _isEqualTo(first.rightChild, second.rightChild);
  }

  /// Check if the current tree contains all the elements of another tree (In
  /// other words, the values in the current tree must be a superset of the
  /// values of the other tree.)
  bool containsSubtree(BinarySearchTree subtree) {
    Set set = {};
    root?.traverseInOrder((value) {
      set.add(value);
    });
    bool isEqual = true;
    subtree.root?.traverseInOrder((value) {
      isEqual = isEqual && set.contains(value);
    });
    return isEqual;
  }
}
