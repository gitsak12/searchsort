class SortingMarkdown {
  static String bubbleSortMarkdown = '''# Bubble Sort

Bubble Sort is a simple comparison-based sorting algorithm. It repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order. The pass through the list is repeated until the list is sorted.

## Time Complexity

- **Worst-case time complexity:** \(O(n^2)\)
  - Occurs when the array is in reverse order.
- **Average-case time complexity:** \(O(n^2)\)
  - Occurs when elements are in jumbled order, and half of the elements are unsorted.
- **Best-case time complexity:** \(O(n)\)
  - Occurs when the array is already sorted.

## Space Complexity

- **Worst-case space complexity:** \(O(1)\)
  - Bubble Sort uses a constant amount of extra space.

## C++ Code Implementation

```cpp
#include <iostream>
using namespace std;

void bubbleSort(int arr[], int n) {
    bool swapped;
    for (int i = 0; i < n - 1; i++) {
        swapped = false;
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
                swapped = true;
            }
        }
        // If no two elements were swapped by the inner loop, then the list is sorted
        if (!swapped) {
            break;
        }
    }
}

void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {
    int arr[] = {64, 34, 25, 12, 22, 11, 90};
    int n = sizeof(arr) / sizeof(arr[0]);
    cout << "Unsorted array: ";
    printArray(arr, n);

    bubbleSort(arr, n);

    cout << "Sorted array: ";
    printArray(arr, n);
    return 0;
}
''';

  static String insertionSortMarkdown = '''# Insertion Sort

Insertion Sort is a simple and intuitive comparison-based sorting algorithm. It builds the final sorted array one item at a time. It is much less efficient on large lists than more advanced algorithms such as quicksort, heapsort, or merge sort.

## Time Complexity

- **Worst-case time complexity:** \(O(n^2)\)
  - Occurs when the array is in reverse order.
- **Average-case time complexity:** \(O(n^2^)\)
  - Occurs when elements are in jumbled order, and half of the elements are unsorted.
- **Best-case time complexity:** \(O(n)\)
  - Occurs when the array is already sorted.

## Space Complexity

- **Worst-case space complexity:** \(O(1)\)
  - Insertion Sort uses a constant amount of extra space.

## C++ Code Implementation

```cpp
#include <iostream>
using namespace std;

void insertionSort(int arr[], int n) {
    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int j = i - 1;
        // Move elements of arr[0..i-1], that are greater than key, to one position ahead of their current position
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        arr[j + 1] = key;
    }
}

void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {
    int arr[] = {12, 11, 13, 5, 6};
    int n = sizeof(arr) / sizeof(arr[0]);
    cout << "Unsorted array: ";
    printArray(arr, n);

    insertionSort(arr, n);

    cout << "Sorted array: ";
    printArray(arr, n);
    return 0;
}
''';
  static String selectionSortMarkdown = '''# Selection Sort

Selection Sort is a simple comparison-based sorting algorithm. It works by dividing the input list into two parts: the sorted part at the beginning and the unsorted part at the end. It repeatedly selects the smallest (or largest, depending on sorting order) element from the unsorted part and swaps it with the leftmost unsorted element, moving the boundary between the sorted and unsorted parts one element to the right.

## Time Complexity

- **Worst-case time complexity:** \(O(n^2)\)
  - Occurs when the array is in reverse order.
- **Average-case time complexity:** \(O(n^2)\)
  - Occurs when elements are in jumbled order, and half of the elements are unsorted.
- **Best-case time complexity:** \(O(n^2)\)
  - Even when the array is already sorted, the algorithm still performs \(O(n^2)\) comparisons.

## Space Complexity

- **Worst-case space complexity:** \(O(1)\)
  - Selection Sort uses a constant amount of extra space.

## C++ Code Implementation

```cpp
#include <iostream>
using namespace std;

void selectionSort(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        // Find the minimum element in the unsorted part
        int minIndex = i;
        for (int j = i + 1; j < n; j++) {
            if (arr[j] < arr[minIndex]) {
                minIndex = j;
            }
        }
        // Swap the found minimum element with the first element of the unsorted part
        swap(arr[minIndex], arr[i]);
    }
}

void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {
    int arr[] = {64, 25, 12, 22, 11};
    int n = sizeof(arr) / sizeof(arr[0]);
    cout << "Unsorted array: ";
    printArray(arr, n);

    selectionSort(arr, n);

    cout << "Sorted array: ";
    printArray(arr, n);
    return 0;
}
''';
  static String quickSortMarkdown = ''' # Quick Sort

Quick Sort is a highly efficient and widely used comparison-based sorting algorithm. It works by selecting a 'pivot' element from the array and partitioning the other elements into two sub-arrays, according to whether they are less than or greater than the pivot. The sub-arrays are then sorted recursively.

## Time Complexity

- **Worst-case time complexity:** \(O(n^2)\)
  - Occurs when the pivot selection is poor, e.g., always picking the smallest or largest element in a sorted array.
- **Average-case time complexity:** \(O(n \log n)\)
  - Occurs when the pivot is chosen such that it roughly splits the array into two equal parts.
- **Best-case time complexity:** \(O(n \log n)\)
  - Occurs when the pivot perfectly splits the array into two equal parts every time.

## Space Complexity

- **Worst-case space complexity:** \(O(\log n)\)
  - Occurs due to the recursive calls in the call stack. This is also the average case.

## C++ Code Implementation

```cpp
#include <iostream>
using namespace std;

// Function to swap two elements
void swap(int& a, int& b) {
    int temp = a;
    a = b;
    b = temp;
}

// Partition function
int partition(int arr[], int low, int high) {
    int pivot = arr[high]; // Choosing the last element as the pivot
    int i = (low - 1);

    for (int j = low; j <= high - 1; j++) {
        if (arr[j] < pivot) {
            i++;
            swap(arr[i], arr[j]);
        }
    }
    swap(arr[i + 1], arr[high]);
    return (i + 1);
}

// QuickSort function
void quickSort(int arr[], int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);

        // Recursively sort elements before partition and after partition
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}

void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {
    int arr[] = {10, 7, 8, 9, 1, 5};
    int n = sizeof(arr) / sizeof(arr[0]);
    cout << "Unsorted array: ";
    printArray(arr, n);

    quickSort(arr, 0, n - 1);

    cout << "Sorted array: ";
    printArray(arr, n);
    return 0;
}
''';

  static String mergeSortMarkdown = ''' # Merge Sort

Merge Sort is a divide-and-conquer sorting algorithm. It divides the input array into two halves, calls itself recursively for the two halves, and then merges the two sorted halves. The merge() function is used for merging two halves.

## Time Complexity

- **Worst-case time complexity:** \(O(n \log n)\)
  - This complexity occurs because the array is always divided into two halves and then merged.
- **Average-case time complexity:** \(O(n \log n)\)
  - Similar to the worst-case, the array is divided and merged efficiently.
- **Best-case time complexity:** \(O(n \log n)\)
  - The array is divided and merged in the same manner regardless of its initial order.

## Space Complexity

- **Worst-case space complexity:** \(O(n)\)
  - Merge Sort requires additional space proportional to the array size for the temporary arrays used during merging.

## C++ Code Implementation

```cpp
#include <iostream>
using namespace std;

void merge(int arr[], int left, int mid, int right) {
    int n1 = mid - left + 1;
    int n2 = right - mid;

    // Create temp arrays
    int L[n1], R[n2];

    // Copy data to temp arrays L[] and R[]
    for (int i = 0; i < n1; i++)
        L[i] = arr[left + i];
    for (int j = 0; j < n2; j++)
        R[j] = arr[mid + 1 + j];

    // Merge the temp arrays back into arr[left..right]
    int i = 0; // Initial index of first subarray
    int j = 0; // Initial index of second subarray
    int k = left; // Initial index of merged subarray
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        } else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }

    // Copy the remaining elements of L[], if there are any
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    // Copy the remaining elements of R[], if there are any
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}

void mergeSort(int arr[], int left, int right) {
    if (left < right) {
        int mid = left + (right - left) / 2;

        // Sort first and second halves
        mergeSort(arr, left, mid);
        mergeSort(arr, mid + 1, right);

        // Merge the sorted halves
        merge(arr, left, mid, right);
    }
}

void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {
    int arr[] = {12, 11, 13, 5, 6, 7};
    int arr_size = sizeof(arr) / sizeof(arr[0]);

    cout << "Unsorted array: ";
    printArray(arr, arr_size);

    mergeSort(arr, 0, arr_size - 1);

    cout << "Sorted array: ";
    printArray(arr, arr_size);
    return 0;
}
''';

  static String heapSortMarkdown = '''# Heap Sort

Heap Sort is a comparison-based sorting algorithm that uses a binary heap data structure. It is an in-place algorithm but not a stable sort. The algorithm works by building a heap from the input data and then repeatedly extracting the maximum element from the heap and reconstructing the heap until the heap is empty.

## Time Complexity

- **Worst-case time complexity:** \(O(n \log n)\)
  - This complexity occurs because building a heap takes \(O(n)\) time, and each extraction of the maximum element followed by heapifying takes \(O(\log n)\) time.
- **Average-case time complexity:** \(O(n \log n)\)
  - Similar to the worst-case, the operations performed are consistent.
- **Best-case time complexity:** \(O(n \log n)\)
  - The heap operations always involve \(O(\log n)\) time for insertions and deletions.

## Space Complexity

- **Worst-case space complexity:** \(O(1)\)
  - Heap Sort is an in-place algorithm, so it does not require additional storage proportional to the input size.

## C++ Code Implementation

```cpp
#include <iostream>
using namespace std;

// Function to heapify a subtree rooted with node i
void heapify(int arr[], int n, int i) {
    int largest = i; // Initialize largest as root
    int left = 2 * i + 1; // left child
    int right = 2 * i + 2; // right child

    // If left child is larger than root
    if (left < n && arr[left] > arr[largest])
        largest = left;

    // If right child is larger than largest so far
    if (right < n && arr[right] > arr[largest])
        largest = right;

    // If largest is not root
    if (largest != i) {
        swap(arr[i], arr[largest]);

        // Recursively heapify the affected sub-tree
        heapify(arr, n, largest);
    }
}

// Main function to do heap sort
void heapSort(int arr[], int n) {
    // Build heap (rearrange array)
    for (int i = n / 2 - 1; i >= 0; i--)
        heapify(arr, n, i);

    // One by one extract an element from heap
    for (int i = n - 1; i >= 0; i--) {
        // Move current root to end
        swap(arr[0], arr[i]);

        // call max heapify on the reduced heap
        heapify(arr, i, 0);
    }
}

void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {
    int arr[] = {12, 11, 13, 5, 6, 7};
    int n = sizeof(arr) / sizeof(arr[0]);

    cout << "Unsorted array: ";
    printArray(arr, n);

    heapSort(arr, n);

    cout << "Sorted array: ";
    printArray(arr, n);
    return 0;
}
 ''';
  static String binarySearchMarkdown = '''# Binary Search

Binary Search is an efficient algorithm for finding an element in a sorted array. It works by repeatedly dividing the search interval in half. If the value of the search key is less than the item in the middle of the interval, the search continues in the lower half, or if it is greater, in the upper half. This process continues until the value is found or the interval is empty.

## Time Complexity

- **Worst-case time complexity:** \(O(\log n)\)
  - Occurs when the algorithm repeatedly divides the search interval in half until the interval is empty.
- **Average-case time complexity:** \(O(\log n)\)
  - Similar to the worst-case, the operations performed are consistent.
- **Best-case time complexity:** \(O(1)\)
  - Occurs when the middle element is the target element on the first comparison.

## Space Complexity

- **Worst-case space complexity:** \(O(1)\)
  - Binary Search is an iterative algorithm and uses a constant amount of space.

## C++ Code Implementation

```cpp
#include <iostream>
using namespace std;

// Iterative Binary Search function
int binarySearch(int arr[], int size, int target) {
    int left = 0;
    int right = size - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        // Check if the target is present at mid
        if (arr[mid] == target)
            return mid;

        // If the target is greater, ignore the left half
        if (arr[mid] < target)
            left = mid + 1;

        // If the target is smaller, ignore the right half
        else
            right = mid - 1;
    }

    // Target is not present in the array
    return -1;
}

void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {
    int arr[] = {2, 3, 4, 10, 40};
    int size = sizeof(arr) / sizeof(arr[0]);
    int target = 10;
    
    cout << "Array: ";
    printArray(arr, size);

    int result = binarySearch(arr, size, target);
    if (result != -1) {
        cout << "Element " << target << " is present at index " << result << endl;
    } else {
        cout << "Element " << target << " is not present in the array" << endl;
    }
    return 0;
}
 ''';

  static String linearSearchMarkdown = '''# Linear Search

Linear Search is the simplest search algorithm. It works by checking each element of the array sequentially until the desired element is found or the end of the array is reached.

## Time Complexity

- **Worst-case time complexity:** \(O(n)\)
  - Occurs when the target element is at the end of the array or not present in the array.
- **Average-case time complexity:** \(O(n)\)
  - On average, the target element could be anywhere in the array.
- **Best-case time complexity:** \(O(1)\)
  - Occurs when the target element is the first element of the array.

## Space Complexity

- **Worst-case space complexity:** \(O(1)\)
  - Linear Search is an iterative algorithm and uses a constant amount of space.

## C++ Code Implementation

```cpp
#include <iostream>
using namespace std;

// Iterative Linear Search function
int linearSearch(int arr[], int size, int target) {
    for (int i = 0; i < size; i++) {
        if (arr[i] == target)
            return i;
    }
    return -1;
}

void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {
    int arr[] = {2, 3, 4, 10, 40};
    int size = sizeof(arr) / sizeof(arr[0]);
    int target = 10;

    cout << "Array: ";
    printArray(arr, size);

    int result = linearSearch(arr, size, target);
    if (result != -1) {
        cout << "Element " << target << " is present at index " << result << endl;
    } else {
        cout << "Element " << target << " is not present in the array" << endl;
    }
    return 0;
}
''';
}
