// A heap is a complete binary tree, also known as a binary heap, that can be
// constructed using a list.
// Heaps come in two flavors:
// 1- Max-heap, in which elements with a higher value have a higher peririty.
// 2- Min-heap, in which elements with a lower value have a higher peririty.
//
// Heap Property (Characteristic):
// * In a max-heap, parent nodes must always contain a value that is greater
//   than or equal to the value in its children. the root node will always
//   contain the highest value.
// * In a min-heap, parent nodes must always contain a value that is less than
//   or equal to the value in its children. the root node will always contain
//   the lowest value.
//
// *****
// Unlike a BST, it is not a requirement of the heap property that the left or
// right child needs to be greater. HEAP IS ONLY A PARTIALY SORTED TREE.
// *****
//
// The Shape Property:
// * A heap must be a complete binary tree. This means that every level must be
//   filled except for the last level.
// * When adding elements to the last level, you must add them from left to
//   right.
//

/// Since there are both max-heaps and min-heaps, we need an enum to keep track
/// of it.
enum Priority { max, min }

class Heap<E extends Comparable<dynamic>> {
  late final List<E> elements;
  final Priority priority;

  Heap({List<E>? elements, this.priority = Priority.max}) {
    this.elements = elements ?? [];
  }

  bool get isEmpty => elements.isEmpty;
  int get size => elements.length;

  // Calling peek will give you the maximum value in the collection for a
  // max-heap, or the minimum value in the collection for a min-heap.
  // This is an O(1) operation.
  E? get peek => isEmpty ? null : elements.first;

  // Helper methods for accessing parent and child indices0
  int _leftChildIndex(int parentIndex) => 2 * parentIndex + 1;
  int _rightChildIndex(int parentIndex) => 2 * parentIndex + 2;
  int _parentIndex(int childIndex) => (childIndex - 1) ~/ 2;

  bool _firstHasHigherPeriority(E valueA, E valueB) {
    if (priority == Priority.max) return valueA.compareTo(valueB) > 0;
    return valueA.compareTo(valueB) < 0;
  }

  int _higherPeriority(int indexA, int indexB) {
    if (indexA >= elements.length) return indexB;
    final valueA = elements[indexA];
    final valueB = elements[indexB];
    final isFirst = _firstHasHigherPeriority(valueA, valueB);
    return (isFirst) ? indexA : indexB;
  }

  void _swapValues(int indexA, int indexB) {
    final temp = elements[indexA];
    elements[indexA] = elements[indexB];
    elements[indexB] = temp;
  }

  // Sifting Up:
  // The procedure for moving a node to a higher level is called sifting up. What
  // you do is compare the node in question to its parent. If the node has higher
  // periority, the you swap the value with that of its parent.
  void _siftUp(int index) {
    var child = index;
    var parent = _parentIndex(child);
    while (child > 0 && child == _higherPeriority(child, parent)) {
      _swapValues(child, parent);
      child = parent;
      parent = _parentIndex(child);
    }
  }

  // The overal complexity of [insert] is O(log n). Adding an element to a list
  // takes only O(1) while sifting elements up in a heap takes O(log n).
  void insert(E value) {
    // first we add the value to the end of the [elements] list
    elements.add(value);
    // Then we start the sifting procedure using the index of the value we just
    // added.
    _siftUp(elements.length - 1);
  }

  @override
  String toString() => elements.toString();
}
