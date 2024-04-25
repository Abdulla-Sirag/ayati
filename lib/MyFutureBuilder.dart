import 'package:flutter/material.dart';
import 'package:prayers_verses/data/local/my_section_dao.dart';
import 'package:prayers_verses/data/local/my_section_database.dart';
import 'package:prayers_verses/data/my_section.dart';
import 'package:prayers_verses/data/my_sections.dart';
import 'package:prayers_verses/my_navigation_bar.dart';
import 'package:prayers_verses/my_verses_utils.dart';
import 'package:prayers_verses/ui/my_section_provider.dart';
import 'package:quran/quran.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFutureBuilder extends StatelessWidget {
  const MyFutureBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MySectionDatabase>(
      future: $FloorMySectionDatabase
          .databaseBuilder('my_section_database.db')
          .build(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error initializing database: ${snapshot.error}'),
                ),
              ),
            );
          }
          final myDatabase = snapshot.data!;
          _initializeDataIfNeeded(myDatabase);

          return MySectionProvider(
            myDatabase: myDatabase,
            child: MaterialApp(
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const MyNavigationBar(),
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _initializeDataIfNeeded(MySectionDatabase database) async {
    final dao = database.mySectionDao;

    // Retrieve shared preferences instance
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the data has already been initialized
    final isDataInitialized = prefs.getBool('initializedData') ?? false;

    if (!isDataInitialized) {
      _initializeData(dao);

      prefs.setBool('initializedData', true);
    }
  }

  _initializeData(MySectionDao dao) {
    for (var myVerses in MySections.myVerses) {
      myVerses.sectionChapter = getSurahNameArabic(myVerses.sectionChapterNo!);
      myVerses.sectionPageNo =
          getPageNumber(myVerses.sectionChapterNo!, myVerses.sectionStart!);
      myVerses.sectionFirstVerse = getVerseText(section: myVerses);

      dao.insertMySection(myVerses);
    }
  }

  String? getVerseText({required MySection section}) {
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


