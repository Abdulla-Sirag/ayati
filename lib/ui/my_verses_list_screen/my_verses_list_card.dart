import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayers_verses/data/my_section.dart';
import 'package:prayers_verses/ui/my_section_viewmodel.dart';
import 'package:provider/provider.dart';

class myVersesListCard extends StatelessWidget {
  const myVersesListCard({super.key, required this.section, required this.screen});

  final MySection section;
  final String screen;

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
              title: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  section.sectionFirstVerse ?? 'No info',
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
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
                Visibility(
                  visible: screen != 'picker',
                  child: ElevatedButton.icon(
                    onPressed: () {
                      /* ... */
                      viewModel.deleteMySection(section);
                    },
                    icon: const Icon(
                      Icons.delete_outline_outlined,
                      size: 16,
                    ),
                    label: const Text('حذف'),
                  ),
                ),
                const SizedBox(width: 8),
                Visibility(
                  visible: !_isPrayerVerses(),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      /* ... */
                      section.filterOption = FilterOption.prayerVerses;
                      viewModel.updateMySection(section);
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 16,
                    ),
                    label: const Text('الصلاة'),
                  ),
                ),
                const SizedBox(width: 8),
                Visibility(
                  visible: !_isPrayerOrMemorizationVerses(),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      /* ... */
                      section.filterOption= FilterOption.memorizationVerses;
                      viewModel.updateMySection(section);
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 16,
                    ),
                    label: const Text('الحفظ'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _isPrayerVerses() {

    return section.filterOption == FilterOption.prayerVerses;
   
  }
  bool _isPrayerOrMemorizationVerses() {
    return section.filterOption == FilterOption.prayerVerses || section.filterOption == FilterOption.memorizationVerses ;
  }
}
