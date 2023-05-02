class BinaryNode<T> {
  BinaryNode<T>? leftChild;
  BinaryNode<T>? rightChild;
  T value;

  BinaryNode(this.value);

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

  @override
  String toString() {
    return _diagram(this);
  }

  String _diagram(
    BinaryNode<T>? node, [
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

extension Checker<E extends Comparable<dynamic>> on BinaryNode<E> {
  // Finding if a tree is type of the BST:
  // The time complexity of this checker is O(n) since we need to traverse the
  // entire tree once. There is alse an O(n) space cost since we're making n 
  // recursive calls.
  bool isBinarySearchTree() {
    return _isBST(this, min: null, max: null);
  }

  bool _isBST(BinaryNode<E>? tree, {E? min, E? max}) {
    // This is the base case. if tree is null, then there are no nodes to
    // inspect. A null node is a BST.
    if (tree == null) return true;
    // This is essentially a bounds check. if the current value exceeds the
    //bounds of min and max, the current node violates BST rules.
    if (min != null && tree.value.compareTo(min) < 0) return false;
    if (max != null && tree.value.compareTo(max) >= 0) return false;
    // This statement contains the recursive calls. When traversing through the
    // left children, the current value is passed in as the max value. This is
    // because any nodes on the left side cannot be greater than the parent.
    // Conversely, when traversing to the right, the min value updated to the
    // current value. Any nodes on the right side must be grater or equal to the
    // parent.
    // If any of the recursive calls evaluate false, the false value will
    // propagate back to the top.
    return _isBST(tree.leftChild, min: min, max: tree.value) &&
        _isBST(tree.rightChild, min: tree.value, max: max);
  }
}
