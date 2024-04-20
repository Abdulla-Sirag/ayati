import 'package:floor/floor.dart';
import 'package:prayers_verses/data/my_section.dart';

@dao
abstract class MySectionDao {
  @Query('SELECT * FROM MySection ORDER BY sectionPageNo ASC')
  Future<List<MySection>> findAllMySections();

  @Query('SELECT * FROM MySection WHERE isRecited = false ORDER BY sectionPageNo ASC')
  Future<List<MySection>> findNotRecitedSections();

  @insert
  Future<void> insertMySection(MySection mySection);

  @update
  Future<void> updateMySection(MySection mySection);

  @delete
  Future<void> deleteMySection(MySection mySection);
}
