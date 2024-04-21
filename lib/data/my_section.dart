import 'package:floor/floor.dart';
import 'package:prayers_verses/ui/my_verses_list_screen/my_verses_list_tab.dart';


enum FilterOption { suggestedVerses, memorizationVerses, prayerVerses }

@entity
class MySection {
  @PrimaryKey(autoGenerate: true)
    int? id;

    String? sectionFirstVerse;
    String? sectionChapter;
    int? sectionChapterNo;
    int? sectionStart;
    int? sectionEnd;
    int? sectionPageNo;
    bool? isLong;
    bool? isRecited= false;
    FilterOption? filterOption;

    
    MySection({
    this.id,
    this.sectionFirstVerse,
    this.sectionChapter,
    this.sectionChapterNo,
    this.sectionStart,
    this.sectionEnd,
    this.sectionPageNo,
    this.isLong,
    this.filterOption,
  });
    
// factory MySection.fromJson(Map<String, dynamic> json) {
//     return MySection(
//       id: json['id'] ?? 0, // Initialize 'id' from JSON, defaulting to 0 if null
//       sectionFirstVerse: json['sectionFirstVerse'],
//       sectionChapter: json['sectionChapter'],
//       sectionChapterNo: json['sectionChapterNo'],
//       sectionStart: json['sectionStart'],
//       sectionEnd: json['sectionEnd'],
//       sectionPageNo: json['sectionPageNo'],
//       isLong: json['isLong'],
//       filterOption: FilterOption.suggestedVerses,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'sectionFirstVerse': sectionFirstVerse,
//       'sectionChapter': sectionChapter,
//       'sectionChapterNo': sectionChapterNo,
//       'sectionStart': sectionStart,
//       'sectionEnd': sectionEnd,
//       'sectionPageNo': sectionPageNo,
//       'isLong': isLong,
//     };
//   }
  
}