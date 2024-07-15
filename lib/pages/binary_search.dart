import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchsort/commons/appBar.dart';
import 'package:searchsort/commons/sorting_markdown.dart';
import 'package:searchsort/provider/search_providers.dart';

class BinarySearch extends ConsumerStatefulWidget {
  const BinarySearch({super.key});

  static TextEditingController controller = TextEditingController();

  static const String routeName = '/search';

  @override
  ConsumerState<BinarySearch> createState() => _BinarySearchState();
}

class _BinarySearchState extends ConsumerState<BinarySearch> {
  Map<String, String> searchName = {};

  @override
  void initState() {
    Future(() {
      ref.read(searchProvider.notifier).randomize();
      infoData();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    //BinarySearch.controller.dispose();
    Provider.autoDispose(
      (ref) => searchProvider,
    );
    // TODO: implement dispose
    super.dispose();
  }

  String info = '';

  infoData() {
    switch (searchName['search']) {
      case 'Binary':
        info = SortingMarkdown.binarySearchMarkdown;
      case 'Linear':
        info = SortingMarkdown.linearSearchMarkdown;
    }
  }

  @override
  Widget build(BuildContext context) {

    searchName =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${searchName['search']} Search',
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
                      data: info,
                    );
                  },
                );
              },
              icon: const Icon(Icons.info)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.07, vertical: size.height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: BinarySearch.controller,
              decoration: InputDecoration(
                labelText: 'Enter the target value',
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (target) {
                ref.read(searchProvider.notifier).setTarget(int.parse(target));
              },
            ),
            SizedBox(height: size.height * 0.01),
            Text('Selected Target: ${ref.watch(searchProvider).target}'),
            SizedBox(height: size.height * 0.01),
            Expanded(
              flex: 2,
              child: SizedBox(
                //color: Colors.red,
                height: size.height * 0.1,
                width: size.width,
                child: GridView.count(
                  crossAxisCount: 5,
                  children: ref
                      .watch(searchProvider)
                      .numbers
                      .asMap()
                      .entries
                      .map((entry) {
                    // Future(() {
                    //   ref.read(searchProvider.notifier).getColor(entry.key);
                    // });
                    return Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: searchName['search'] == 'Binary'
                              ? getColorBinary(entry.key)
                              : getColorLinear(entry.key),
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(2),
                      child: Center(
                        child: Text(entry.value.toString()),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                ref.watch(searchProvider).message,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
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
                onPressed: () {
                  ref.read(searchProvider.notifier).randomize();
                },
                child: const Text(
                  'Reset',
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
                  switch (searchName['search']) {
                    case 'Binary':
                      ref.read(searchProvider.notifier).binarySearch(
                          0, 24, ref.watch(searchProvider).target);
                    case 'Linear':
                      ref
                          .read(searchProvider.notifier)
                          .linearSearch(ref.watch(searchProvider).target);
                  }
                },
                child: const Text(
                  'Search',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getColorBinary(int index) {
    if (index == ref.watch(searchProvider).mid) {
      return Colors.green;
    } else if (index >= ref.watch(searchProvider).lowProvider &&
        index <= ref.watch(searchProvider).highProvider) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  getColorLinear(int index) {
    if (index == ref.watch(searchProvider).currentIndex) {
      return Colors.green;
    } else if (index < ref.watch(searchProvider).currentIndex) {
      return Colors.grey;
    } else if (index > ref.watch(searchProvider).currentIndex) {
      return Colors.blue;
    }
  }
}
