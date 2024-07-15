import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchsort/pages/binary_search.dart';

class SearchProvider extends ChangeNotifier {
  List<int> numbers = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19];
  String message = '';
  int target = -1;
  int mid = 0;
  int lowProvider = 0;
  int highProvider = 0;
  Color gridChildColour = Colors.white;

  randomize() {
    numbers = List<int>.generate(25, (index) => index + 1);
    mid = 0;
    lowProvider = 0;
    highProvider = 24;
    target = -1;
    currentIndex = -1;
    message = '';
    BinarySearch.controller.clear();
    notifyListeners();
  }

  setTarget(int val) {
    target = val;
    notifyListeners();
  }

  binarySearch(int low, int high, int key) async {
    if (low > high) {
      message = 'Element not exist';
      await Future.delayed(const Duration(seconds: 2));
      notifyListeners();
      return;
    }
    mid = (low + (high - low) / 2).toInt();

    // element found
    if (key == numbers[mid]) {
      message = 'Element found at index $mid';
      await Future.delayed(const Duration(seconds: 2));
      notifyListeners();
      return true;
    }

    if (key > numbers[mid]) {
      message = 'Searching in upper half';
      await Future.delayed(const Duration(seconds: 2));
      lowProvider = mid + 1;
      notifyListeners();
      return binarySearch(mid + 1, high, key);
    } else {
      message = 'Searching in lower half';
      await Future.delayed(const Duration(seconds: 2));
      highProvider = mid - 1;
      notifyListeners();
      return binarySearch(low, mid - 1, key);
    }
  }

  getColor(int index) {
    if (index == mid) {
      gridChildColour = Colors.green;
      notifyListeners();
    } else if (index >= lowProvider && index <= highProvider) {
      gridChildColour = Colors.blue;
      notifyListeners();
    } else {
      gridChildColour = Colors.grey;
      notifyListeners();
    }
  }

  int currentIndex = -1;

  linearSearch(int target) async {
    currentIndex = 0;
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
    for (; currentIndex < numbers.length;) {
      if (target == numbers[currentIndex]) {
        message = 'Element found at index $currentIndex';
        await Future.delayed(const Duration(seconds: 1));
        notifyListeners();
        break;
      } else {
        message = 'Element not found';
        currentIndex++;
        await Future.delayed(const Duration(seconds: 1));
        notifyListeners();
      }
    }
  }
}

final searchProvider =
    ChangeNotifierProvider<SearchProvider>((ref) => SearchProvider());
