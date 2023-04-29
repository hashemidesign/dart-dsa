class AvlNode<T> {
  AvlNode(this.value);
  T value;
  AvlNode<T>? leftChild;
  AvlNode<T>? rightChild;

  void traverseInOrder(void Function(T value) action) {
    leftChild?.traverseInOrder(action);
    action(value);
    rightChild?.traverseInOrder(action);
  }

  void traversePreOrder(void Function(T value) action) {
    action(value);
    leftChild?.traversePreOrder(action);
    rightChild?.traversePreOrder(action);
  }

  void traversePostOrder(void Function(T value) action) {
    leftChild?.traversePostOrder(action);
    rightChild?.traversePostOrder(action);
    action(value);
  }

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
