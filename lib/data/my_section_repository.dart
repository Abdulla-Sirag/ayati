import 'package:prayers_verses/data/local/my_section_database.dart';
import 'package:prayers_verses/data/my_section.dart';

class MySectionRepository {
  final MySectionDatabase database;

  MySectionRepository(this.database);

  Future<List<MySection>> getPrayerSections() async {
    // debugPrint('First _section.filter: i am in prayer');
    return database.mySectionDao.findPrayerSections(FilterOption.prayerVerses.index);
  }

  Future<List<MySection>> getMemorizationSections() async {
    return database.mySectionDao.findMemorizationSections(FilterOption.memorizationVerses.index);
  }

  Future<List<MySection>> getSuggestedSections() async {
    // debugPrint('First _section.filter: i am in suggestions');
    return database.mySectionDao.findSuggestedSections(FilterOption.suggestedVerses.index);
  }

  Future<List<MySection>> getNotRecitedSections() async {

    final notRecitedSections= await database.mySectionDao.findNotRecitedSections(FilterOption.prayerVerses.index);
    // debugPrint('First _section.filter: i am in not recited');


    if (notRecitedSections.isEmpty) {
      // debugPrint('First _section.filter: i am in not recited empty');
      
      final allSections = await database.mySectionDao.findPrayerSections(FilterOption.prayerVerses.index);

      if (allSections.isEmpty) {
              // debugPrint('First _section.filter: i am in not recited empty 2');

        //add a toast here with the message: List is empty
      } else {
        for (var section in allSections) {
          section.isRecited = false;
          updateMySection(section);
        }
      }
    }
    return notRecitedSections;
  }

  Future<void> insertMySection(MySection mySection) async {
    return database.mySectionDao.insertMySection(mySection);
  }

  Future<void> updateMySection(MySection mySection) async {
    return await database.mySectionDao.updateMySection(mySection);
  }

  Future<void> deleteMySection(MySection mySection) async {
    return database.mySectionDao.deleteMySection(mySection);
  }
}