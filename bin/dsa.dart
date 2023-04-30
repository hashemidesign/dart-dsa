import 'package:dsa/avl_tree.dart';
import 'package:dsa/binary_search_tree.dart';

void main(List<String> arguments) {
  final tree = AvlTree<int>();
  for (var i = 0; i < 15; i++) {
    tree.insert(i);
  }
  print(tree);
  tree.remove(11);
  print(tree);
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
