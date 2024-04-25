import 'package:flutter/material.dart';
import 'package:prayers_verses/data/my_section.dart';
import 'package:prayers_verses/my_verses_utils.dart';
import 'package:quran/quran.dart';

class VerseDisplayScreen extends StatelessWidget {
  final MySection section;

  VerseDisplayScreen({required this.section});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(section.sectionChapter!),
        centerTitle: true,
      ),
      body: _buildVerseList(),
    );
  }

  Widget _buildVerseList() {
    final List<String> verses = getVerseText();

    return ListView.builder(
      itemCount: verses.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(verses[index],
            textAlign: TextAlign.center,),),
        );
      },
    );
  }

  List<String> getVerseText() {
    int chapterNo = section.sectionChapterNo!;
    int firstVerseNo = section.sectionStart!;
    int lastVerseNo = section.sectionEnd!;

    List<String>? verses= [];
    String verse;

    while ( firstVerseNo <= lastVerseNo) {

      verse = getVerse(chapterNo, firstVerseNo);

      verses!.add('$verse ${getVerseEndSymbol(firstVerseNo)}');
          
      firstVerseNo++;
    }

    return verses!;
  }

}
