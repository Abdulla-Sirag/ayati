import 'package:floor/floor.dart';


@entity
class MySection {
  @PrimaryKey(autoGenerate: true)
    int? id;

    String? sectionFirstVerse;
    String? sectionChapter;
    int? sectionStart;
    int? sectionEnd;
    int? sectionPageNo;
    bool? isLong;
    bool? isRecited= false;

    MySection({
    this.id,
    this.sectionFirstVerse,
    this.sectionChapter,
    this.sectionStart,
    this.sectionEnd,
    this.sectionPageNo,
    this.isLong,
  });
    
factory MySection.fromJson(Map<String, dynamic> json) {
    return MySection(
      id: json['id'] ?? 0, // Initialize 'id' from JSON, defaulting to 0 if null
      sectionFirstVerse: json['sectionFirstVerse'],
      sectionChapter: json['sectionChapter'],
      sectionStart: json['sectionStart'],
      sectionEnd: json['sectionEnd'],
      sectionPageNo: json['sectionPageNo'],
      isLong: json['isLong'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sectionFirstVerse': sectionFirstVerse,
      'sectionChapter': sectionChapter,
      'sectionStart': sectionStart,
      'sectionEnd': sectionEnd,
      'sectionPageNo': sectionPageNo,
      'isLong': isLong,
    };
  }
  
}