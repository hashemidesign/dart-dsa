import 'trie_node.dart';

class StringTrie {
  // in Dart a String is a collection of UTF-16 code units, so that's why the
  // type for TrieNode is int rather than String.
  TrieNode<int> root = TrieNode(key: null, parent: null);

  // The time complexity of [insertion] is [O(k)], where [k] is the number of
  // [code units] We're trying to insert.
  void insert(String text) {
    // [current] keeps track of traversal progress, which starts with the root
    // node.
    var current = root;
    // The trie stores each code unit in a separate node. We first check if the
    // node exists in the children map. If it doesn't, we create a new node.
    // During each loop, we move [current] to the next node
    for (var codeUnit in text.codeUnits) {
      current.children[codeUnit] ??= TrieNode(
        key: codeUnit,
        parent: current,
      );
      current = current.children[codeUnit]!;
    }
    current.isTerminating = true;
  }

  // The time complexity of [contains] is [O(k)], where [k] is the length of the
  // string that you're using for the search.
  bool contains(String text) {
    var current = root;
    for (var codeUnit in text.codeUnits) {
      final child = current.children[codeUnit];
      if (child == null) return false;
      current = child;
    }
    return current.isTerminating;
  }
}
