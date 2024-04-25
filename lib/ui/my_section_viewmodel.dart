import 'package:flutter/foundation.dart';
import 'package:prayers_verses/data/my_section.dart';
import 'package:prayers_verses/data/my_section_repository.dart';
import 'package:prayers_verses/ui/my_verses_list_screen/my_verses_list_tab.dart';

class MySectionViewModel extends ChangeNotifier {
  late MySectionRepository repository;
  List<MySection> mySections = [];
  
  List<MySection> NotRecitedSections = [];

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
    notifyListeners();
  }

  void loadNotRecitedSections() async {
    NotRecitedSections = await repository.getNotRecitedSections();
    notifyListeners();
  }

  void addMySection(MySection mySection) async {
    await repository.insertMySection(mySection);
    // loadMySections();
  }

  void updateMySection(MySection mySection) async {

    try {
      await repository.updateMySection(mySection);
    } catch (e) {
      print("Error updating MySection: $e");
    }
    
    // try to remove this
    // loadNotRecitedSections();
  }

  void deleteMySection(MySection mySection) async {
    await repository.deleteMySection(mySection);
    // loadMySections();
    // loadNotRecitedSections();
    
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
}
