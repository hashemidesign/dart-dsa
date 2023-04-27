import 'package:dsa/binary_search_tree.dart';

void main(List<String> arguments) {
  final tree = createExampleTree();
  final tree2 = createExampleTree();
  print(tree);
  if (tree.contains(5)) print('Found 5');
  print("equality check before removal: ${tree.isEqualTo(tree2)}");
  tree.remove(3);
  print(tree);
  print("equality check before removal: ${tree.isEqualTo(tree2)}");
  print(
      "second tree is superset of first tree: ${tree2.containsSubtree(tree)}");
}

BinarySearchTree<int> createExampleTree() {
  var tree = BinarySearchTree<int>();
  tree.insert(3);
  tree.insert(1);
  tree.insert(4);
  tree.insert(0);
  tree.insert(2);
  tree.insert(5);
  return tree;
}
