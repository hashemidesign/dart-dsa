import 'package:dsa/trees/heap.dart';

void main(List<String> arguments) {
  final heap = Heap<int>();
  heap.insert(10);
  heap.insert(7);
  heap.insert(5);
  heap.insert(2);
  heap.insert(1);
  print(heap);

  print(heap.indexOf(2));
}
