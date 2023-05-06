import 'package:dsa/trees/heap.dart';

void main(List<String> arguments) {
  final heap = Heap<int>();
  heap.insert(8);
  heap.insert(6);
  heap.insert(5);
  heap.insert(4);
  heap.insert(3);
  heap.insert(2);
  heap.insert(1);
  print(heap);

  heap.insert(7);
  print(heap);
}
