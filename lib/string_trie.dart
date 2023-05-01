import 'trie_node.dart';

class StringTrie {
  // in Dart a String is a collection of UTF-16 code units, so that's why the
  // type for TrieNode is int rather than String.
  TrieNode<int> root = TrieNode(key: null, parent: null);
}
