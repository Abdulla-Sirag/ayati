import 'package:flutter/material.dart';
import 'package:prayers_verses/ui/my_section_viewmodel.dart';
import 'package:prayers_verses/ui/my_verses_list_screen/my_verse_dialog.dart';
import 'package:prayers_verses/ui/my_verses_list_screen/my_verses_list_card.dart';
import 'package:provider/provider.dart';

import '../../data/my_section.dart';

class MyVersesListTab extends StatefulWidget {
  const MyVersesListTab({super.key});

  static FilterOption selectedFilter = FilterOption.prayerVerses;

  @override
  State<MyVersesListTab> createState() => _MyVersesListTabState();
}

class _MyVersesListTabState extends State<MyVersesListTab> {

  MySectionViewModel? viewModel;

  void _showMyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyVersesDialog();
        });
  }

  void _filterList(FilterOption filter) {
    
    setState(() {
      MyVersesListTab.selectedFilter = filter;
      // Add your database filtering logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    viewModel = Provider.of<MySectionViewModel>(context, listen: true);

    // Call loadMySections when widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel?.loadMySections( MyVersesListTab.selectedFilter);
    });

    return Scaffold(
      body: Consumer<MySectionViewModel>(builder: (context, viewModel, _) {
        final mySections = viewModel.mySections;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    style: TextButton.styleFrom(
                        side: BorderSide(
                      color:  MyVersesListTab.selectedFilter == FilterOption.prayerVerses
                          ? Colors.blue
                          : Colors.grey,
                    )),
                    onPressed: () =>
                      _filterList(FilterOption.prayerVerses)
                    ,
                    child: const Text('آيات الصلاة')),
                    OutlinedButton(
                    style: TextButton.styleFrom(
                        side: BorderSide(
                      color:  MyVersesListTab.selectedFilter == FilterOption.memorizationVerses
                          ? Colors.blue
                          : Colors.grey,
                    )),
                    onPressed: () => _filterList(FilterOption.memorizationVerses),
                    child: const Text('آيات الحفظ')),
                    OutlinedButton(
                    style: TextButton.styleFrom(
                        side: BorderSide(
                      color:  MyVersesListTab.selectedFilter == FilterOption.suggestedVerses
                          ? Colors.blue
                          : Colors.grey,
                    )),
                    onPressed: () => _filterList(FilterOption.suggestedVerses),
                    child: const Text('آيات مقترحة'))
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: mySections.length,
                itemBuilder: (BuildContext context, int index) {
                  return myVersesListCard(
                    section: mySections[index],
                  );
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 233, 219, 179),
        foregroundColor: const Color.fromARGB(255, 34, 33, 32),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MyVersesDialog(filterOption:  MyVersesListTab.selectedFilter,);
              });
        },
        tooltip: 'إضافة',
        child: const Icon(Icons.add),
      ),
    );
  }
}
