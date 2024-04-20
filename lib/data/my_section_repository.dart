import 'package:prayers_verses/data/local/my_section_database.dart';
import 'package:prayers_verses/data/my_section.dart';

class MySectionRepository {
  final MySectionDatabase database;

  MySectionRepository(this.database);

  Future<List<MySection>> getAllMySections() async {
    return database.mySectionDao.findAllMySections();
  }

  Future<List<MySection>> getNotRecitedSections() async {

    final NotRecitedSections= await database.mySectionDao.findNotRecitedSections();

    if (NotRecitedSections.isEmpty) {
      
      final allSections = await database.mySectionDao.findAllMySections();

      if (allSections.isEmpty) {
        //add a toast here with the message: List is empty
      } else {
        for (var section in allSections) {
          section.isRecited = false;
          updateMySection(section);
        }
      }
    }
    return NotRecitedSections;
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