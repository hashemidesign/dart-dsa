class TrieNode<T> {
  /// [key] holds the data for the node. You use it in a map of key-value pairs
  /// to store children nodes.
  // This is nullable because the root node of the trie has no key.
  T? key;
  // TrieNode holds a reference to its parent. this ref simplifies the remove
  // method later on.
  TrieNode<T>? parent;
  // A TrieNode may holds multiple children.
  Map<T, TrieNode<T>?> children = {};

  /// [isTerminating] acts as a marker for the end of a collection.
  bool isTerminating = false;

  TrieNode({this.key, this.parent});
}
