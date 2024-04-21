import 'dart:math';
import 'package:flutter/material.dart';
import 'package:prayers_verses/data/my_section.dart';
import 'package:prayers_verses/ui/my_section_viewmodel.dart';
import 'package:prayers_verses/ui/my_verses_picker_screen/my_verses_picker.dart';
import 'package:provider/provider.dart';

class MyVersesTab extends StatefulWidget {
  const MyVersesTab({super.key});

  @override
  State<MyVersesTab> createState() => _MyVersesTabState();
}

class _MyVersesTabState extends State<MyVersesTab> {
  MySectionViewModel? viewModel;
  List<MySection>? mySections;
  int selectedFirstIndex = -1;
  int selectedSecondIndex = -1;
  String firstRightButton = 'اختياري';
  String firstLeftButton = 'عشوائي';
  String secondRightButton = 'اختياري';
  String secondLeftButton = 'عشوائي';

  MySection? _firstSection, _secondSection;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    viewModel = Provider.of<MySectionViewModel>(context, listen: true);

    // Call loadMySections when widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel?.loadNotRecitedSections();
    });

    mySections = viewModel?.NotRecitedSections;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          child: Center(
            child: Image.asset('assets/images/my_verses.png',
                width: 200, height: 200),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _firstSection == null
                          ? ' '
                          : _firstSection!.sectionEnd
                              .toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _firstSection == null
                          ? ' '
                          : _firstSection!.sectionChapter!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _firstSection == null
                          ? ' '
                          : _firstSection!.sectionStart
                              .toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                _firstSection == null
                          ? ' '
                          : _firstSection!.sectionFirstVerse!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            children: [
              const SizedBox(width: 8),
              ElevatedButton(
                  onPressed: () {
                    switch (firstLeftButton) {
                      case 'عشوائي':
                        _getFirstRandomIndex();
                        break;

                      case 'إلغاء':
                        _cancelFirstIndex();
                        break;
                    }
                  },
                  child: Text(firstLeftButton)),
              const SizedBox(width: 8),
              ElevatedButton(
                  onPressed: () {
                    switch (firstRightButton) {
                      case 'اختياري':
                        _getFirstIndex(context);
                        break;

                      case 'تأكيد':
                        _confirmFirstIndex();
                        break;
                    }
                  },
                  child: Text(firstRightButton)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _secondSection == null
                          ? ' '
                          : _secondSection!.sectionEnd
                              .toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _secondSection == null
                          ? ' '
                          : _secondSection!.sectionChapter!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _secondSection == null
                          ? ' '
                          : _secondSection!
                              .sectionStart
                              .toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                _secondSection == null
                          ? ' '
                          : _secondSection!.sectionFirstVerse!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            children: [
              const SizedBox(width: 8),
              ElevatedButton(
                  onPressed: () {
                    switch (secondLeftButton) {
                      case 'عشوائي':
                        _getSecondRandomIndex();
                        break;

                      case 'إلغاء':
                        _cancelSecondIndex();
                        break;
                    }
                  },
                  child: Text(secondLeftButton)),
              const SizedBox(width: 8),
              ElevatedButton(
                  onPressed: () {
                    switch (secondRightButton) {
                      case 'اختياري':
                        _getSecondIndex(context);
                        break;

                      case 'تأكيد':
                        _confirmSecondIndex();
                        break;
                    }
                  },
                  child: Text(secondRightButton)),
            ],
          ),
        ),
      ],
    );
  }

  _getFirstIndex(BuildContext context) async {
    final section = await Navigator.push<MySection>(
      context,
      MaterialPageRoute(builder: (context) => const MyVersesPicker()),
    );

    if (section != null) {
      setState(() {
        _firstSection = section;
        firstRightButton = 'تأكيد';
        firstLeftButton = 'إلغاء';
      });
    }
  }

  _getSecondIndex(BuildContext context) async {
    final section = await Navigator.push<MySection>(
      context,
      MaterialPageRoute(builder: (context) => const MyVersesPicker()),
    );

    if (section != null) {
      setState(() {
        _secondSection = section;
        secondRightButton = 'تأكيد';
        secondLeftButton = 'إلغاء';
      });
    }
  }

  _getFirstRandomIndex() {
    Random random = Random();
    final randomIndex = random.nextInt(mySections!.length);

    setState(() {
      _firstSection = mySections![randomIndex];
      firstRightButton = 'تأكيد';
      firstLeftButton = 'إلغاء';
    });
  }

  _getSecondRandomIndex() {
    Random random = Random();
    int randomIndex = random.nextInt(mySections!.length);

    setState(() {
      _secondSection = mySections![randomIndex];
      secondRightButton = 'تأكيد';
      secondLeftButton = 'إلغاء';
    });
  }

  void _cancelSecondIndex() {
    setState(() {
      secondRightButton = 'اختياري';
      secondLeftButton = 'عشوائي';
    });
  }

  void _cancelFirstIndex() {
    setState(() {
      firstRightButton = 'اختياري';
      firstLeftButton = 'عشوائي';
    });
  }

  void _confirmSecondIndex() {

    _secondSection!.isRecited = true;
    viewModel?.updateMySection(_secondSection!);

    setState(() {
      secondRightButton = 'اختياري';
      secondLeftButton = 'عشوائي';
    });
  }

  void _confirmFirstIndex() async {
        
    _firstSection!.isRecited = true;
    viewModel?.updateMySection(_firstSection!);

    setState(() {
      firstRightButton = 'اختياري';
      firstLeftButton = 'عشوائي';
    });
  }
}
