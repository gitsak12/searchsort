import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchsort/commons/appBar.dart';
import 'package:searchsort/pages/binary_search.dart';
import 'package:searchsort/pages/bubble_sort.dart';
import 'package:searchsort/provider/sort_providers.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SortSearch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
      ),
      home: Home(),
      initialRoute: '/',
      routes: {
        '/bubbleSort': (context) => BubbleSort(),
        '/search': (context) => BinarySearch(),
      },
    );
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar('SearchSort'),
      body: SingleChildScrollView(
        child: Container(
          height: size.height * 0.9,
          width: size.width,
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08, vertical: size.height * 0.01),
          //color: Colors.red,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sort Algorithms',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SortTypeButton(
                text: 'Bubble Sort',
                routeName: BubbleSort.routeName,
                sortName: 'Bubble',
              ),
              SortTypeButton(
                  text: 'Insertion Sort',
                  routeName: BubbleSort.routeName,
                  sortName: 'Insertion'),
              SortTypeButton(
                  text: 'Selection Sort',
                  routeName: BubbleSort.routeName,
                  sortName: 'Selection'),
              SortTypeButton(
                  text: 'Quick Sort',
                  routeName: BubbleSort.routeName,
                  sortName: 'Quick'),
              SortTypeButton(
                  text: 'Merge Sort',
                  routeName: BubbleSort.routeName,
                  sortName: 'Merge'),
              SortTypeButton(
                  text: 'Heap Sort',
                  routeName: BubbleSort.routeName,
                  sortName: 'Heap'),
              Text(
                'Search Algorithms',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SearchTypeButton(
                  text: 'Binary Search',
                  searchName: 'Binary',
                  routeName: BinarySearch.routeName),
              SearchTypeButton(
                  text: 'Linear Search',
                  searchName: 'Linear',
                  routeName: BinarySearch.routeName),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTypeButton extends StatelessWidget {
  final String text;
  final String routeName;
  final String searchName;

  const SearchTypeButton(
      {super.key,
      required this.text,
      required this.searchName,
      required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(1, 5),
          ),
        ],
      ),
      child: ListTile(
        tileColor: Colors.purple.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.navigate_next,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            routeName,
            arguments: {'search': searchName},
          );
        },
      ),
    );
  }
}

class SortTypeButton extends StatelessWidget {
  final text;
  final String routeName;
  final String sortName;

  const SortTypeButton(
      {super.key,
      required this.text,
      required this.routeName,
      required this.sortName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(1, 5),
          ),
        ],
      ),
      child: ListTile(
        tileColor: Colors.purple.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.navigate_next,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            routeName,
            arguments: {'sort': sortName},
          );
        },
      ),
    );
  }
}
