import 'package:flutter/material.dart';
import 'package:prayers_verses/ui/my_section_viewmodel.dart';
import 'package:prayers_verses/ui/my_verses_list_screen/my_verse_dialog.dart';
import 'package:prayers_verses/ui/my_verses_list_screen/my_verses_list_card.dart';
import 'package:provider/provider.dart';

class MyVersesListTab extends StatefulWidget {
  const MyVersesListTab({super.key});

  @override
  State<MyVersesListTab> createState() => _MyVersesListTabState();
}

class _MyVersesListTabState extends State<MyVersesListTab> {
  void _showMyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const MyVersesDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final viewModel = Provider.of<MySectionViewModel>(context, listen: true);

    // Call loadMySections when widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.loadMySections();
    });

    return Scaffold(
      body: Consumer<MySectionViewModel>(builder: (context, viewModel, _) {
        final mySections = viewModel.mySections;

        return ListView.builder(
          itemCount: mySections.length,
          itemBuilder: (BuildContext context, int index) {
            return myVersesListCard(
              section: mySections[index],
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 233, 219, 179),
        foregroundColor: const Color.fromARGB(255, 34, 33, 32),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const MyVersesDialog();
              });
        },
        tooltip: 'إضافة',
        child: const Icon(Icons.add),
      ),
    );
  }
}
