import 'package:floor/floor.dart';
import 'package:prayers_verses/data/my_section.dart';

@dao
abstract class MySectionDao {
  @Query(
      'SELECT * FROM MySection WHERE filterOption = :index ORDER BY sectionPageNo ASC, sectionChapterNo ASC')
  Future<List<MySection>> findPrayerSections(int index);

  @Query(
      'SELECT * FROM MySection WHERE filterOption = :index ORDER BY sectionPageNo ASC, sectionChapterNo ASC')
  Future<List<MySection>> findMemorizationSections(int index);

  @Query(
      'SELECT * FROM MySection WHERE filterOption = :index ORDER BY sectionPageNo ASC, sectionChapterNo ASC')
  Future<List<MySection>> findSuggestedSections(int index);

  @Query(
      'SELECT * FROM MySection WHERE filterOption = :index AND isRecited = false ORDER BY sectionPageNo ASC, sectionChapterNo ASC')
  Future<List<MySection>> findNotRecitedSections(int index);

  @insert
  Future<void> insertMySection(MySection mySection);

  @update
  Future<void> updateMySection(MySection mySection);

  @delete
  Future<void> deleteMySection(MySection mySection);
}
