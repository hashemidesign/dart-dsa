import 'package:dsa/string_trie.dart';

void main(List<String> arguments) {
  final trie = StringTrie();
  trie.insert("cut");
  trie.insert("cute");
  assert(trie.contains("cut"));
  assert(trie.contains("cute"));
  print('\n-------- Removing "cut" ------');
  trie.remove("cut");
  assert(!trie.contains("cut"));
  assert(trie.contains("cute"));
  print('"cute" is still in the trie');
}
