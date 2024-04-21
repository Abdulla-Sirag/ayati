import 'package:flutter/material.dart';
import 'package:prayers_verses/ui/my_section_viewmodel.dart';
import 'package:prayers_verses/ui/my_verses_list_screen/my_verses_list_card.dart';
import 'package:provider/provider.dart';

class MyVersesPicker extends StatelessWidget {
  const MyVersesPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final viewModel = Provider.of<MySectionViewModel>(context, listen: true);

    // Call loadMySections when widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.loadNotRecitedSections();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prays Verses'),
        backgroundColor: const Color.fromARGB(255, 233, 219, 179),
      ),
      body: Consumer<MySectionViewModel>(builder: (context, viewModel, _) {
        final mySections = viewModel.NotRecitedSections;

        return ListView.builder(
          itemCount: mySections.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context, mySections[index]);
              },
              child: myVersesListCard(
                section: mySections[index],
              ),
            );
          },
        );
      }),
    );
  }
}
