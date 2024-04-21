import 'package:flutter/material.dart';
import 'package:prayers_verses/ui/my_verses_list_screen/my_verses_list_tab.dart';
import 'package:prayers_verses/ui/my-verses_screen/my_verses_tab.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
              title: const Text ('آياتي'),
              backgroundColor: const Color.fromARGB(255, 233, 219, 179),
              centerTitle: true,
              
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromARGB(255, 233, 219, 179),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 233, 219, 179),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.edit_note_rounded,),
            label: 'آياتي',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.list)),
            label: 'قائمتي',
          ),
        ],
      ),
      body: _buildPage(currentPageIndex),
    );
  }
}


Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const MyVersesTab(); // Custom class for myVerses tab
      case 1:
        return const MyVersesListTab(); // Custom class for other tab
      default:
        return Container();
    }
  }
