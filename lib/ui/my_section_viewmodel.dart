import 'package:flutter/foundation.dart';
import 'package:prayers_verses/data/my_section.dart';
import 'package:prayers_verses/data/my_section_repository.dart';
import 'package:prayers_verses/ui/my_verses_list_screen/my_verses_list_tab.dart';
import 'package:quran/quran.dart';

class MySectionViewModel extends ChangeNotifier {
  late MySectionRepository repository;
  List<MySection> mySections = [];
  
  List<MySection> NotRecitedSections = [];
  
  double memorizationRatio = 0;
  
  MySectionViewModel(this.repository);

  void updateRepository(MySectionRepository repository) {
    this.repository = repository;
    // loadMySections(
    //     filter); // You might want to reload data when repository is updated
  }


  void loadMySections(FilterOption filter) async {

    switch (filter) {
      case FilterOption.suggestedVerses:
        mySections = await repository.getSuggestedSections();
        break;
      case FilterOption.memorizationVerses:
        mySections = await repository.getMemorizationSections();
        break;
      case FilterOption.prayerVerses:
        mySections = await repository.getPrayerSections();
        break;
    }
    calculateMemorizationRatio();
    notifyListeners();
  }

  void loadNotRecitedSections() async {
    NotRecitedSections = await repository.getNotRecitedSections();
    notifyListeners();
  }

  void addMySection(MySection mySection) async {
    await repository.insertMySection(mySection);
    loadMySections(MyVersesListTab.selectedFilter);
  }

  void updateMySection(MySection mySection) async {

    try {
      await repository.updateMySection(mySection);
    } catch (e) {
      print("Error updating MySection: $e");
    }
    
    // try to remove this
    loadMySections(MyVersesListTab.selectedFilter);
    loadNotRecitedSections();
  }

  void deleteMySection(MySection mySection) async {
    await repository.deleteMySection(mySection);
    loadMySections(MyVersesListTab.selectedFilter);
    loadNotRecitedSections();
    
  }

  int countVersesNo() {
  int sum = 0;
  int end, start;
  for (MySection section in mySections) {
    // Add null checks for sectionStart and sectionEnd
    start = section.sectionStart ?? 0; // Default to 0 if null
    end = section.sectionEnd ?? 0; // Default to 0 if null

    try {
      // Ensure both start and end are non-null before subtraction
      sum += (end - start + 1); // +1 if you want to include sectionEnd in the count
    } catch (e) {
      // Handle the exception
      print("Exception occurred: ${e.toString()}");
      // You can choose to ignore the section or take other actions here
    }
  }
  return sum;
}


  int countChaptersNo() {

    Set<int> uniqueChapterNumbers = {};
    int sectionStart;

// Iterate through your mySections list
    for (MySection section in mySections) {

      sectionStart = section.sectionChapterNo ?? 0;

      uniqueChapterNumbers.add(sectionStart);

    }
    return uniqueChapterNumbers.length;
  }

  countPagesNo() {

     Set<int> uniquePagesNumbers = {};
    int sectionFirstPage, sectionSecondPage;

// Iterate through your mySections list
    for (MySection section in mySections) {
      sectionFirstPage = getPageNumber(section.sectionChapterNo ?? 1, section.sectionStart ?? 1);
      sectionSecondPage = getPageNumber(section.sectionChapterNo ?? 1, section.sectionEnd ?? 1);

      for (int i= sectionFirstPage; i <= sectionSecondPage; i++) {
        uniquePagesNumbers.add(i);
      }
    }
    return uniquePagesNumbers.length;

  }

Future<double> calculateWordsCount() async {
  int wordsCount = 0;

  for (MySection section in mySections) {
    int? chapterNo = section.sectionChapterNo;
    int? startVerse = section.sectionStart;
    int? endVerse = section.sectionEnd;

    // Retrieve verses from Quran package
    for (int verseNo = startVerse!; verseNo <= endVerse!; verseNo++) {
      // Get verse text
      String verseText = await getVerse(chapterNo!, verseNo);
      
      // Count words in verse text
      List<String> words = verseText.split(' ');
      wordsCount += words.length;
    }
  }

debugPrint('totalWordsCount1: ${wordsCount}');
  // Pass wordsCount to callback function
  return wordsCount.toDouble();
}

 Future<void> calculateMemorizationRatio () async {
  
      double totalWordsCount = 77439;
      double wordsCount = await calculateWordsCount();
      debugPrint('totalWordsCount2: ${wordsCount}');
      memorizationRatio = (wordsCount / totalWordsCount * 100);
      debugPrint('totalWordsCount3: $memorizationRatio');

}

}
