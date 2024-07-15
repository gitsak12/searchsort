import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:searchsort/commons/sorting_markdown.dart';
import 'package:searchsort/provider/sort_providers.dart';

class BubbleSort extends ConsumerStatefulWidget {
  static const routeName = '/bubbleSort';

  const BubbleSort({super.key});

  @override
  ConsumerState<BubbleSort> createState() => _BubbleSortState();
}

class _BubbleSortState extends ConsumerState<BubbleSort> {
  late List<int> numbers;
  Map<String, String> sortName = {};
  int samplesize = 500;
  late StreamController<List<int>> streamController;
  late Stream<List<int>> stream;
  String infoData = '';

  @override
  void initState() {
    streamController = StreamController();
    stream = streamController.stream;
    Future(() {
      ref.read(sortListProvider.notifier).randomize();
      sortName =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      infoDatafunc();
    });

    // TODO: implement initState
    super.initState();
  }

  _randomize() {
    numbers = [];
    for (int i = 0; i < samplesize; i++) {
      numbers.add(Random().nextInt(samplesize));
    }
    streamController.add(numbers);
  }

  // _sort() async {
  //   int n = numbers.length;
  //   for (int i = 0; i < n; i++) {
  //     for (int j = 0; j < n - i - 1; j++) {
  //       if (numbers[j] > numbers[j + 1]) {
  //         int temp = numbers[j];
  //         numbers[j] = numbers[j + 1];
  //         numbers[j + 1] = temp;
  //       }
  //       await Future.delayed(const Duration(microseconds: 500));
  //       //setState(() {});
  //       streamController.add(numbers);
  //     }
  //   }
  // }
  String infoDatafunc() {
    switch (sortName['sort']) {
      case 'Bubble':
        infoData = SortingMarkdown.bubbleSortMarkdown;
      case 'Insertion':
        infoData = SortingMarkdown.insertionSortMarkdown;
      case 'Selection':
        infoData = SortingMarkdown.selectionSortMarkdown;
      case 'Quick':
        infoData = SortingMarkdown.quickSortMarkdown;
      case 'Merge':
        infoData = SortingMarkdown.mergeSortMarkdown;
      case 'Heap':
        infoData = SortingMarkdown.heapSortMarkdown;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    numbers = ref.watch(sortListProvider).myBars;
    int counter = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${sortName['sort']} Sort',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  //isScrollControlled: true,
                  enableDrag: true,
                  showDragHandle: true,
                  //scrollControlDisabledMaxHeightRatio: 120,
                  context: context,
                  backgroundColor: Colors.white,
                  sheetAnimationStyle: AnimationStyle(
                      curve: Curves.easeInOutQuint,
                      duration: const Duration(milliseconds: 600)),
                  builder: (ctx) {
                    return Markdown(
                      data: infoData,
                    );
                  },
                );
              },
              icon: const Icon(Icons.info)),
        ],
      ),
      body: Row(
        children: numbers.map((int number) {
          counter++;
          return CustomPaint(
            painter: BarPainter(
              width: (size.width / samplesize),
              value: number.toDouble(),
              index: counter,
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          bottom: size.height * 0.01,
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.greenAccent)),
                onPressed: ref.read(sortListProvider.notifier).randomize,
                child: const Text(
                  'Randomize',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.lightGreenAccent)),
                onPressed: () {
                  switch (sortName['sort']) {
                    case 'Bubble':
                      ref.read(sortListProvider.notifier).bubbleSort();
                    case 'Insertion':
                      ref.read(sortListProvider.notifier).insertionSort();
                    case 'Selection':
                      ref.read(sortListProvider.notifier).selectionSort();
                    case 'Quick':
                      ref.read(sortListProvider.notifier).quickSort(
                          0, ref.watch(sortListProvider).myBars.length - 1);
                    case 'Merge':
                      ref.read(sortListProvider.notifier).mergeSort(
                          0, ref.watch(sortListProvider).myBars.length - 1);
                    case 'Heap':
                      ref.read(sortListProvider.notifier).heapSort();
                  }
                },
                child: const Text(
                  'Sort',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  late final double width;
  late final double value;
  late final int index;

  BarPainter({
    required this.width,
    required this.value,
    required this.index,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (value < 50) {
      paint.color = const Color(0xFF02244B).withOpacity(0.1);
    } else if (value < 100) {
      paint.color = const Color(0xFF02244B).withOpacity(0.2);
    } else if (value < 150) {
      paint.color = const Color(0xFF02244B).withOpacity(0.3);
    } else if (value < 200) {
      paint.color = const Color(0xFF02244B).withOpacity(0.4);
    } else if (value < 250) {
      paint.color = const Color(0xFF02244B).withOpacity(0.5);
    } else if (value < 300) {
      paint.color = const Color(0xFF02244B).withOpacity(0.6);
    } else if (value < 350) {
      paint.color = const Color(0xFF02244B).withOpacity(0.7);
    } else if (value < 400) {
      paint.color = const Color(0xFF02244B).withOpacity(0.8);
    } else if (value < 450) {
      paint.color = const Color(0xFF02244B).withOpacity(0.9);
    } else {
      paint.color = const Color(0xFF02244B);
    }
    // if (this.value < 500 * .10) {
    //   paint.color = Color(0xFFDEEDCF);
    // } else if (this.value < 500 * .20) {
    //   paint.color = Color(0xFF02244B);
    // } else if (this.value < 500 * .30) {
    //   paint.color = Color(0xFF99D492);
    // } else if (this.value < 500 * .40) {
    //   paint.color = Color(0xFF74C67A);
    // } else if (this.value < 500 * .50) {
    //   paint.color = Color(0xFF56B870);
    // } else if (this.value < 500 * .60) {
    //   paint.color = Color(0xFF39A96B);
    // } else if (this.value < 500 * .70) {
    //   paint.color = Color(0xFF1D9A6C);
    // } else if (this.value < 500 * .80) {
    //   paint.color = Color(0xFF188977);
    // } else if (this.value < 500 * .90) {
    //   paint.color = Color(0xFF137177);
    // } else {
    //   paint.color = Color(0xFF0E4D64);
    // }

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.square;
    //canvas.translate(size.width / 2, 0);

    canvas.drawLine(
        Offset(index * width, 0), Offset(index * width, value), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
