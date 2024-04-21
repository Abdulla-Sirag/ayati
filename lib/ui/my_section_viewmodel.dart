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
}
