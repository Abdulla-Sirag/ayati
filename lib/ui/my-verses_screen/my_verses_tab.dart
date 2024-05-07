import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:prayers_verses/data/my_section.dart';
import 'package:prayers_verses/my_verses_utils.dart';
import 'package:prayers_verses/ui/my_section_viewmodel.dart';
import 'package:prayers_verses/ui/my_verses_display_screen/my_verses_display_screen.dart';
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

    viewModel = Provider.of<MySectionViewModel>(context, listen: false);

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
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VerseDisplayScreen(section: _firstSection!),
                ),
              );
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    _firstSection == null
                              ? ' '
                              : _firstSection!.sectionFirstVerse!,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
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
                         mySections!.isEmpty  ?  null : _getFirstRandomIndex(context);
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
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VerseDisplayScreen(section: _secondSection!),
                ),
              );
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    _secondSection == null
                              ? ' '
                              : _secondSection!.sectionFirstVerse!,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
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

                        mySections!.isEmpty  ? null : _getSecondRandomIndex(context);
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

  _getFirstRandomIndex(BuildContext context) {
    Random random = Random();
    bool isLong = true;
    int? randomIndex;
    int limiter = 0;

    
    while (isLong) {
      if (limiter == 50) {
        MyVersesUtils.showSnackBar(
            context: context,
            msg: 'لا يوجد مقاطع طويلة',
            icon: Icons.playlist_remove);
        break;
      }

      randomIndex = random.nextInt(mySections!.length);
      debugPrint(
          'Limiter $limiter : ${mySections![randomIndex].isLong}, ${mySections![randomIndex].sectionChapter}');
      
      if (isLong == mySections![randomIndex].isLong) {
        isLong =false;
      }

      limiter++;
    }

    setState(() {
      _firstSection = mySections![randomIndex!];
      firstRightButton = 'تأكيد';
      firstLeftButton = 'إلغاء';
    });
  }

  _getSecondRandomIndex(BuildContext context) {
    Random random = Random();
    bool? isLong= true;
    int? randomIndex;
    int limiter= 0;

    while( isLong! ) {
      
      if (limiter == 50) {
        
        MyVersesUtils.showSnackBar(context: context, msg: 'لا يوجد مقاطع قصيرة', icon:  Icons.playlist_remove);
        break;
        
      }

      randomIndex = random.nextInt(mySections!.length);
      isLong= mySections![randomIndex].isLong;
      debugPrint('Limiter $limiter : ${mySections![randomIndex].isLong}, ${mySections![randomIndex].sectionChapter}');

      limiter++;

    }

    setState(() {
      _secondSection = mySections![randomIndex!];
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
