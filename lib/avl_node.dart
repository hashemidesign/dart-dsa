import 'package:dsa/traversable_binary_node.dart';

class AvlNode<T> extends TraversableBinaryNode<T> {
  AvlNode(this.value);
  @override
  T value;

  @override
  AvlNode<T>? leftChild;

  @override
  AvlNode<T>? rightChild;

  /// The [height] of a node is the **longest** distance from the current node
  /// to a leaf node.
  int height = 0;

  /// The height of the left and right children of each node must differ at most
  /// by 1. this number is known as the **balance factor**.
  /// a [balanceFactor] of 2 or -2 or something more extreme indicates an 
  /// unbalanced tree.
  int get balanceFactor => leftHeight - rightHeight;
  // If a particular child is null, its height is considered to be -1.
  int get leftHeight => leftChild?.height ?? -1;
  int get rightHeight => rightChild?.height ?? -1;

  @override
  String toString() {
    return _diagram(this);
  }

  String _diagram(
    AvlNode<T>? node, [
    String top = '',
    String root = '',
    String bottom = '',
  ]) {
    if (node == null) {
      return '$root null\n';
    }
    if (node.leftChild == null && node.rightChild == null) {
      return '$root ${node.value}\n';
    }
    final a = _diagram(node.rightChild, '$top ', '$top┌──', '$top│ ');
    final b = '$root${node.value}\n';
    final c = _diagram(node.leftChild, '$bottom│ ', '$bottom└──', '$bottom ');
    return '$a$b$c';
  }
}
