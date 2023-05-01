import 'package:dsa/string_trie.dart';
import 'package:dsa/trie.dart';

void main(List<String> arguments) {
  final trie = Trie<int, List<int>>();
  trie.insert('cut'.codeUnits);
  trie.insert('cute'.codeUnits);
  if (trie.contains('cute'.codeUnits)) {
    print('cute is in the trie');
  }
  trie.remove('cut'.codeUnits);
  print(trie.contains('cut'.codeUnits));
}
