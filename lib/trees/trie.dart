import 'nodes/trie_node.dart';

class Trie<E, T extends Iterable<E>> {
  // T represents the iterable collections that you'll add to the trie
  // E represnts the type for the TrieNode key
  TrieNode<E> root = TrieNode(key: null, parent: null);

  void insert(T collection) {
    var current = root;
    for (E element in collection) {
      current.children[element] ??= TrieNode(
        key: element,
        parent: current,
      );
      current = current.children[element]!;
    }
    current.isTerminating = true;
  }

  void remove(T collection) {
    var current = root;
    for (E element in collection) {
      final child = current.children[element];
      if (child == null) return;
      current = child;
    }
    if (!current.isTerminating) return;
    current.isTerminating = false;

    while (current.parent != null &&
        current.children.isEmpty &&
        !current.isTerminating) {
      current.parent!.children[current.key!] = null;
      current = current.parent!;
    }
  }

  bool contains(T collection) {
    var current = root;
    for (E element in collection) {
      final child = current.children[element];
      if (child == null) return false;
      current = child;
    }
    return current.isTerminating;
  }
}
