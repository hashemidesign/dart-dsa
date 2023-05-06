import 'package:dsa/trees/heap.dart';

void main(List<String> arguments) {
  final heap = Heap<int>();
  heap.insert(120);
  heap.insert(51);
  heap.insert(3);
  heap.insert(90);
  heap.insert(81);
  heap.insert(111);
  heap.insert(35);
  print(heap);

  heap.insert(150);
  print(heap);

  heap.remove();
  print(heap);

  heap.removeAt(2);
  print(heap);
}
