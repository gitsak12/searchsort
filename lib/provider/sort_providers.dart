import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sort_providers.g.dart';

class SortList extends ChangeNotifier {
  List<int> myBars = <int>[];
  late Ref ref;

  SortList(this.ref) : super();

  void randomize() {
    myBars = [];
    print('ty');
    int samplesize = 500;
    for (int i = 0; i < samplesize; i++) {
      myBars.add(Random().nextInt(samplesize));
    }
    notifyListeners();
    //streamController.add(numbers);
  }

  bubbleSort() async {
    int n = myBars.length;
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        //print('running looop');
        if (myBars[j] > myBars[j + 1]) {
          int temp = myBars[j];
          myBars[j] = myBars[j + 1];
          myBars[j + 1] = temp;
        }
        await Future.delayed(const Duration(microseconds: 2));
        notifyListeners();
        //setState(() {});
      }
    }
  }

  insertionSort() async {
    int n = myBars.length;
    for (int i = 0; i < n; i++) {
      int temp = myBars[i];
      int j = i - 1;
      while (j >= 0 && myBars[j] > temp) {
        myBars[j + 1] = myBars[j];
        j--;
        await Future.delayed(const Duration(microseconds: 2));
        notifyListeners();
      }
      myBars[j + 1] = temp;
      await Future.delayed(const Duration(microseconds: 2));
      notifyListeners();
    }
  }

  selectionSort() async {
    for (int i = 0; i < myBars.length; i++) {
      for (int j = i + 1; j < myBars.length; j++) {
        if (myBars[i] > myBars[j]) {
          int temp = myBars[j];
          myBars[j] = myBars[i];
          myBars[i] = temp;
        }
        await Future.delayed(const Duration(microseconds: 2));
        notifyListeners();
        // await Future.delayed(_getDuration(), () {});

        // _streamController.add(_numbers);
      }
    }
  }

  Future<int> partition(int s, int e) async {
    int pivot = myBars[s];
    int count = 0;
    for (int i = s + 1; i <= e; i++) {
      if (myBars[i] <= pivot) {
        count++;
      }
    }
    int pivotIndex = s + count;

    //swap func starts
    int temp = myBars[s];
    myBars[s] = myBars[pivotIndex];
    myBars[pivotIndex] = temp;
    //swap func ends
    await Future.delayed(const Duration(milliseconds: 500));
    notifyListeners();

    int left = s, right = e;
    while (left < pivotIndex && right > pivotIndex) {
      while (myBars[left] <= myBars[pivotIndex]) {
        left++;
      }
      while (myBars[right] > myBars[pivotIndex]) {
        right--;
      }
      if (left < pivotIndex && right > pivotIndex) {
        //swap(myBars[left++], arr[right--]);
        int temp = myBars[left];
        myBars[left] = myBars[right];
        myBars[right] = temp;

        left++;
        right--;
        await Future.delayed(const Duration(microseconds: 100));
        notifyListeners();
      }
    }
    return pivotIndex;
  }

  quickSort(int s, int e) async {
    if (s >= e) {
      return;
    }

    int p = await partition(s, e);
    quickSort(s, p - 1);
    quickSort(p + 1, e);
  }

  Future<void> merge(int s, int e) async {
    int mid = (s + e) ~/ 2;
    int len1 = mid - s + 1;
    int len2 = e - mid;

    List<int> first = List.generate(len1, (index) => 0);
    List<int> second = List.generate(len2, (index) => 0);
    int mainArrayIndex = s;
    for (int i = 0; i < len1; i++) {
      first[i] = myBars[mainArrayIndex++];
    }
    mainArrayIndex = mid + 1;
    for (int i = 0; i < len2; i++) {
      second[i] = myBars[mainArrayIndex++];
    }

    int index1 = 0;
    int index2 = 0;
    mainArrayIndex = s;
    while (index1 < len1 && index2 < len2) {
      if (first[index1] < second[index2]) {
        myBars[mainArrayIndex++] = first[index1++];
        await Future.delayed(const Duration(milliseconds: 3));
        notifyListeners();
      } else {
        myBars[mainArrayIndex++] = second[index2++];
        await Future.delayed(const Duration(milliseconds: 3));
        notifyListeners();
      }
    }
    while (index1 < len1) {
      myBars[mainArrayIndex++] = first[index1++];
      await Future.delayed(const Duration(milliseconds: 3));
      notifyListeners();
    }

    while (index2 < len2) {
      myBars[mainArrayIndex++] = second[index2++];
      await Future.delayed(const Duration(milliseconds: 3));
      notifyListeners();
    }
  }

  mergeSort(int s, int e) async {
    if (s >= e) {
      return;
    }
    int mid = (s + e) ~/ 2;

    await mergeSort(s, mid);
    await mergeSort(mid + 1, e);
    await Future.delayed(const Duration(milliseconds: 3));
    notifyListeners();
    await merge(s, e);
  }

  heapSort() async {
    for (int i = myBars.length ~/ 2; i >= 0; i--) {
      await heapify(myBars, myBars.length, i);
      await Future.delayed(const Duration(milliseconds: 5));
      notifyListeners();
    }
    for (int i = myBars.length - 1; i >= 0; i--) {
      int temp = myBars[0];
      myBars[0] = myBars[i];
      myBars[i] = temp;
      await heapify(myBars, i, 0);
      await Future.delayed(const Duration(milliseconds: 5));
      notifyListeners();
    }
  }

  heapify(List<int> arr, int n, int i) async {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    if (l < n && arr[l] > arr[largest]) largest = l;

    if (r < n && arr[r] > arr[largest]) largest = r;

    if (largest != i) {
      int temp = myBars[i];
      myBars[i] = myBars[largest];
      myBars[largest] = temp;
      heapify(arr, n, largest);
    }
    await Future.delayed(const Duration(milliseconds: 5));
    notifyListeners();
  }
}

@riverpod
class EventController extends _$EventController {
  StreamController build() {
    return StreamController();
  }
}

final sortListProvider = ChangeNotifierProvider<SortList>((ref) {
  return SortList(ref);
});
