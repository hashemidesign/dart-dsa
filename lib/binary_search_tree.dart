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

  @override
  String toString() => root.toString();
}
