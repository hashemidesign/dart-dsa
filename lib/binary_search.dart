// Two conditions need to be met for implementing binary search on lists:
// 1- The collection must be sorted.
// 2- The underlying collection must be able to perform random index lookup in
//    constant time (Wich a Dart List can do it).
//
// Binary search is one of the most efficient searching algorithms with a time
// complexity of O(log n).
// * indexOf method on List uses a linear search with O(n) time complexity.

extension SortedList<E extends Comparable<dynamic>> on List<E> {
  int? binarySearch(E value, [int? start, int? end]) {
    // First, check if [start] and [end] are [null]. If so, we create a range
    // that covers the entire collection.
    final startIndex = start ?? 0;
    final endIndex = end ?? length;
    // Check if the range contains at least one element. If it doesn't, the
    // search has failed, and returns [null]
    if (startIndex >= endIndex) return null;
    // Find the middle index of the range.
    final size = endIndex - startIndex;
    final middle = startIndex + size ~/ 2;
    
    // Do the binary search recursively till the middle point matches the given
    // value and return its [index] or the last condition met and return [null].
    if (this[middle] == value) {
      return middle;
    }
    else if (value.compareTo(this[middle]) < 0) {
      return binarySearch(value, startIndex, middle);
    } else {
      return binarySearch(value, middle + 1, endIndex);
    }
  }
}
