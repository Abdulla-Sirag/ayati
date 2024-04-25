import 'package:flutter/material.dart';
import 'package:prayers_verses/data/my_section.dart';
import 'package:prayers_verses/my_verses_utils.dart';
import 'package:prayers_verses/ui/my_section_viewmodel.dart';
import 'package:prayers_verses/ui/my_verses_list_screen/my_verses_list_tab.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart';

class MyVersesDialog extends StatefulWidget {
  final FilterOption? filterOption;

  const MyVersesDialog({super.key, this.filterOption});

  @override
  State<MyVersesDialog> createState() => _MyVersesDialogState();
}

class _MyVersesDialogState extends State<MyVersesDialog> {
  final _formKey = GlobalKey<FormState>();
  final bool _isLongVerse = true;
  final MySection _section = MySection();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('First _section.filter: ${widget.filterOption}');
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MySectionViewModel>();

    return AlertDialog(
      title: const Directionality(
        textDirection: TextDirection.rtl,
        child: Text('أياتي'),
      ),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'رقم السورة'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رجاء أدخل رقم السورة';
                    }
                    return null;
                  },
                  onSaved: (value) =>
                      _section.sectionChapterNo = int.parse(value!),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'الآية الأولى'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رجاء أدخل رقم الآية';
                    }
                    return null;
                  },
                  onSaved: (value) => _section.sectionStart = int.parse(value!),
                ), const SizedBox(width: 4),
                // const SizedBox(width: 4),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'الآية الأخيرة'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رجاء أدخل رقم الآية';
                    }
                    return null;
                  },
                  onSaved: (value) => _section.sectionEnd = int.parse(value!),
                ),
                const SizedBox(height: 10),
                RadioListTile<bool>(
                  title: const Text('آية طويلة'),
                  value: true,
                  groupValue: _section.isLong,
                  onChanged: (bool? value) {
                    setState(() {
                      debugPrint(value.toString());
                      _section.isLong = value ?? false;

                      debugPrint('Final _section.isLong: ${_section.isLong}');
                    });
                  },
                ),
                RadioListTile<bool>(
                  title: const Text('آية قصيرة'),
                  value: false,
                  groupValue: _section.isLong,
                  onChanged: (bool? value) {
                    setState(() {
                      _section.isLong = value ?? false;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close dialog without selecting
          },
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            // Get the values entered by the user
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              // how to log data.
              debugPrint('Final _section.filter: ${MyVersesListTab.selectedFilter}');
              _generateSection();
              viewModel.addMySection(_section);

              Navigator.pop(context); // Close dialog
            } 
          },
          child: const Text('حفظ'),
        ),
      ],
    );
  }
  
  void _generateSection() {
    _section.filterOption = MyVersesListTab.selectedFilter;
    _section.sectionChapter = getSurahNameArabic(_section.sectionChapterNo!);
     _section.sectionPageNo =
        getPageNumber(_section.sectionChapterNo!, _section.sectionStart!);
    _section.sectionFirstVerse = _getVerseText(section: _section);

  }

String? _getVerseText({required MySection section}) {
    int chapterNo = section.sectionChapterNo!;
    int verseNo = section.sectionStart!;

    String verse = getVerse(chapterNo, verseNo);

    while (MyVersesUtils.isShortText(verse)) {
      verse =
          '$verse ${getVerseEndSymbol(verseNo)} ${getVerse(chapterNo, verseNo + 1)}';

      verseNo++;
    }

    return verse;
  }
  
}
