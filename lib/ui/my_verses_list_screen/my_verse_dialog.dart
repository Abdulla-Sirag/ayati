import 'package:flutter/material.dart';
import 'package:prayers_verses/data/my_section.dart';
import 'package:prayers_verses/ui/my_section_viewmodel.dart';
import 'package:prayers_verses/ui/my_verses_list_screen/my_verses_list_tab.dart';
import 'package:provider/provider.dart';

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
                  decoration: const InputDecoration(labelText: 'البداية'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رجاء أدخل رقم الآية';
                    }
                    return null;
                  },
                  onSaved: (value) => _section.sectionStart = int.parse(value!),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'السورة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رجاء أدخل إسم السورة ';
                    }
                    return null;
                  },
                  onSaved: (value) => _section.sectionChapter = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'النهاية'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رجاء أدخل رقم الآية';
                    }
                    return null;
                  },
                  onSaved: (value) => _section.sectionEnd = int.parse(value!),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'الآية'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رجاء أدخل الآية';
                    }
                    return null;
                  },
                  onSaved: (value) => _section.sectionFirstVerse = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'الصفحة'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رجاء أدخل رقم الصفحة';
                    }
                    return null;
                  },
                  onSaved: (value) =>
                      _section.sectionPageNo = int.parse(value!),
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
                      debugPrint(value.toString());
                      _section.isLong = value ?? false;
                      debugPrint('Final _section.isLong: ${_section.isLong}');
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
              _section.filterOption= MyVersesListTab.selectedFilter;
              _section.sectionChapterNo= 1;
              viewModel.addMySection(_section);

              Navigator.pop(context); // Close dialog
            }
          },
          child: const Text('حفظ'),
        ),
      ],
    );
  }
}
