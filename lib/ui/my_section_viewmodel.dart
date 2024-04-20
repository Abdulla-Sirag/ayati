import 'package:flutter/foundation.dart';
import 'package:prayers_verses/data/my_section.dart';
import 'package:prayers_verses/data/my_section_repository.dart';

class MySectionViewModel extends ChangeNotifier {
  late MySectionRepository repository;
  List<MySection> mySections = [];
  
  List<MySection> NotRecitedSections = [];

  MySectionViewModel(this.repository);

  void updateRepository(MySectionRepository repository) {
    this.repository = repository;
    loadMySections(); // You might want to reload data when repository is updated
  }



  void loadMySections() async {
    mySections = await repository.getAllMySections();
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
