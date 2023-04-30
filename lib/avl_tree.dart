// In 1962, Adelson-Velsky and Landis came up with the first self-balancing
// binary search tree: The AVL Tree.
// * Other self-balancing BSTs are: 
//   - red-black tree
//   - splay tree
// A balanced tree is the key to optimizing the performance of the BST. three
// main states of balance tree are:
// 1- Perfect Balance: this means every level of the tree is filled with nodes,
//    from top to bottom.
//    * In this case, the tree can only be perfect with a particular number of
//      elements. for example a tree with 1, 3 or 7 nodes [can] be perfectly
//      balanced, but a tree with 2,4, 5 or 6 cannot be perfectly balanced.
// 2- Good-enough Balance: this means every level of the tree must be filled,
//    except for the bottom level.
// 3- Unbalanced
//
// Rotations:
// The procedure used to balance a BST are known as rotations. There are four
// rotations in total. Thes are known as:
// - left rotation
// - left-right rotation
// right rotation
// right-left rotation

import 'avl_node.dart';
import 'dart:math' as math;

class AvlTree<E extends Comparable<dynamic>> {
  AvlNode<E>? root;

  void insert(E value) {
    root = _insertAt(root, value);
  }

  AvlNode<E> _insertAt(AvlNode<E>? node, E value) {
    if (node == null) {
      return AvlNode(value);
    }
    if (value.compareTo(node.value) < 0) {
      node.leftChild = _insertAt(node.leftChild, value);
    } else {
      node.rightChild = _insertAt(node.rightChild, value);
    }
    // Instead of returning the node directly after inserting, we pass it into 
    // balanced method. Passing it ensures every node in the call stack is 
    // checked for balancing issues. We also update the node's height.
    final balancedNode = balanced(node);
    balancedNode.height =
        1 + math.max(balancedNode.leftHeight, balancedNode.rightHeight);
    return balancedNode;
  }

  void remove(E value) {
    root = _remove(root, value);
  }

  AvlNode<E>? _remove(AvlNode<E>? node, E value) {
    if (node == null) return null;
    if (value == node.value) {
      if (node.leftChild == null && node.rightChild == null) {
        return null;
      }
      if (node.leftChild == null) {
        return node.rightChild;
      }
      if (node.rightChild == null) {
        return node.leftChild;
      }
      node.value = node.rightChild!.min.value;
      node.rightChild = _remove(node.rightChild, node.value);
    } else if (value.compareTo(node.value) < 0) {
      node.leftChild = _remove(node.leftChild, value);
    } else {
      node.rightChild = _remove(node.rightChild, value);
    }
    // Just like insertion, we check for balancing and also recalculating the
    // height.
    final balancedNode = balanced(node);
    balancedNode.height =
        1 + math.max(balancedNode.leftHeight, balancedNode.rightHeight);
    return balancedNode;
  }

  bool contains(E value) {
    var current = root;
    while (current != null) {
      if (current.value == value) {
        return true;
      }
      if (value.compareTo(current.value) < 0) {
        current = current.leftChild;
      } else {
        current = current.rightChild;
      }
    }
    return false;
  }

  AvlNode<E> leftRotate(AvlNode<E> node) {
    // The right child is chosen as the pivot point. This node will replace the
    // rotated node as the root of the subtree. That means it'll move up a level
    final pivot = node.rightChild!;
    // The node to be rotated will become the left child of the pivot. It moves
    // down a level.
    node.rightChild = pivot.leftChild;
    // The pivot's leftChild can now be set to the rotated node.
    pivot.leftChild = node;
    // Update the heights of the rotated node and the pivot.
    node.height = 1 + math.max(node.leftHeight, node.rightHeight);
    pivot.height = 1 + math.max(pivot.leftHeight, pivot.rightHeight);
    // Finally, return the pivot so that it can replace the rotated node in
    // the tree.
    return pivot;
  }

  AvlNode<E> rightRotate(AvlNode<E> node) {
    // Right rotation is the symmetrical opposite of left rotation. When a
    // series of left children causing an imbalance, it's time for a right
    // rotation.
    final pivot = node.leftChild!;
    node.leftChild = pivot.rightChild;
    pivot.rightChild = node;
    node.height = 1 + math.max(node.leftHeight, node.rightHeight);
    pivot.height = 1 + math.max(pivot.leftHeight, pivot.rightHeight);
    return pivot;
  }

  AvlNode<E> rightLeftRotate(AvlNode<E> node) {
    // In two previous cases, we encountered with all left or all right
    // situations. What if we have a zigzag mode? here is one solution:
    if (node.rightChild == null) return node;
    node.rightChild = rightRotate(node.rightChild!);
    return leftRotate(node);
  }

  AvlNode<E> leftRightRotate(AvlNode<E> node) {
    // left-right rotation is the symmetrical opposite of the right-left
    // rotation.
    if (node.leftChild == null) return node;
    node.leftChild = leftRotate(node.leftChild!);
    return rightRotate(node);
  }

  AvlNode<E> balanced(AvlNode<E> node) {
    switch (node.balanceFactor) {
      case 2:
        // The **left** child is heavier (contains more nodes) than the right
        // child. This means that we need to use either [right] or [left-right]
        // rotations.
        final left = node.leftChild;
        if (left != null && left.balanceFactor == -1) {
          return leftRightRotate(node);
        } else {
          return rightRotate(node);
        }
      case -2:
        // The **right** child is heavier (contains more nodes) than the left
        // child. This means that we need to use either [left] or [right-left]
        // rotations.
        final right = node.rightChild;
        if (right != null && right.balanceFactor == 1) {
          return rightLeftRotate(node);
        } else {
          return leftRotate(node);
        }
      default:
        // The node is balanced.
        return node;
    }
  }

  @override
  String toString() => root.toString();
}

extension _MinFinder<E> on AvlNode<E> {
  AvlNode<E> get min => leftChild?.min ?? this;
}
