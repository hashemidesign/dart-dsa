import 'nodes/trie_node.dart';

class StringTrie {
  // in Dart a String is a collection of UTF-16 code units, so that's why the
  // type for TrieNode is int rather than String.
  TrieNode<int> root = TrieNode(key: null, parent: null);
  // Storing all texts in a set for further uses.
  // * By storing all the strings in the trie separately as a set, we've lost 
  //   the space complexity benefits that trie gives us.
  final Set<String> _allStrings = {};

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
    // Add text to allString property.
    _allStrings.add(text);
  }

  // The time complexity of [remove] is [O(k)], where [k] represents the number
  // of [code units] in the string that we're trying to remove.
  void remove(String text) {
    // Check if the code unit collection that you want to remove is part of the
    // trie and point current to the last node of the collection. If we don't
    // find your search string or the final node isn't marked as terminating,
    // that means the collection isn't in the trie and we can abort.
    var current = root;
    for (final codeUnit in text.codeUnits) {
      final child = current.children[codeUnit];
      if (child == null) return;
      current = child;
    }
    if (!current.isTerminating) return;
    // We set isTerminating to false so the current node can be removed by the
    // loop in the next step.
    current.isTerminating = false;
    // remove text from allStrings property
    _allStrings.remove(text);
    // Since nodes can be shared, we don't want to remove code units that
    // belongs to another collection.
    // If there are no other children in the current node, it means that other
    // collections don't depend on the current node.
    // We also check to see if the current node is terminating. If it is, then
    // belongs to another collection.
    // As long as [current] satisfies these conditions, we continually backtrack
    // through the parent property and remove the nodes.
    while (current.parent != null &&
        current.children.isEmpty &&
        !current.isTerminating) {
      current.parent!.children[current.key!] = null;
      current = current.parent!;
    }
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

  // [matchPrefix] has a time complexity of [O(k x m)], where k represents the
  // longest collection matching the prefix and m represents the number of
  // collections that match the prefix.
  // Recall that lists have a time complexity of [O(k x n)], where n is the
  // number of elements in the [entire] collection.
  // => for large sets of data in which each collection is uniformly
  //    distributed, tries have far better performance than using lists for
  //    prefix matching.
  List<String> matchPrefix(String prefix) {
    // We start by verifying that the trie contains the prefix. If not, we
    // return an empty list.
    var current = root;
    for (final codeUnit in prefix.codeUnits) {
      final child = current.children[codeUnit];
      if (child == null) return [];
      current = child;
    }
    // After we found the node that marks the end of the prefix, we call a
    // recursive helper method to find all the sequences after the current node.
    return _moreMatches(prefix, current);
  }

  List<String> _moreMatches(String prefix, TrieNode<int> node) {
    // If the current node is terminating one, we add what we've got to the
    // results.
    List<String> results = [];
    if (node.isTerminating) results.add(prefix);
    // We need to check the current node's children. for every child node, we
    // recursively call _moreMatches to seek out other terminating nodes.
    for (final child in node.children.values) {
      final codeUnit = child!.key!;
      results.addAll(_moreMatches(
        '$prefix${String.fromCharCode(codeUnit)}',
        child,
      ));
    }
    return results;
  }

  Set<String> get allStrings => _allStrings;
  int get Length => _allStrings.length;
  bool get isEmpty => _allStrings.isEmpty;
}
