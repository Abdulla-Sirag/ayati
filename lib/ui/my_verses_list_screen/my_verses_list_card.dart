import 'package:flutter/material.dart';
import 'package:prayers_verses/my_verses_utils.dart';
import 'package:prayers_verses/ui/my_section_viewmodel.dart';
import 'package:provider/provider.dart';

class myVersesListCard extends StatelessWidget {
  const myVersesListCard({super.key, this.section});

  final section;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MySectionViewModel>(context, listen: false);

    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              trailing: const Icon(Icons.format_quote),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(section.sectionFirstVerse ?? 'No info'),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      '${section.sectionChapter}: آية ${section.sectionStart} >> ${section.sectionEnd}'),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                TextButton(
                  child: const Text('حذف'),
                  onPressed: () {
                    /* ... */
                    viewModel.deleteMySection(section);
                  },
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('تعديل'),
                  onPressed: () {
                    /* ... */
                    MyVersesUtils.showSnackBar(context: context, 
                    msg: 'التعديل غير مسموح');
                    // MyVersesUtils.showToast(msg: 'Never allowed');
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
