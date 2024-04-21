import 'package:floor/floor.dart';
import 'package:prayers_verses/data/my_section.dart';

class FilterOptionConverter extends TypeConverter<FilterOption, String> {
  @override
  String encode(FilterOption value) {
    // If the value is null, return a default string or throw an exception
    if (value == null) throw ArgumentError('FilterOption cannot be null');
    return value.toString().split('.').last;
  }

  @override
  FilterOption decode(String databaseValue) {
    // Handle the case where the databaseValue is null or empty
    if (databaseValue == null || databaseValue.isEmpty) {
      throw ArgumentError('Database value cannot be null or empty');
    }
    return FilterOption.values.firstWhere(
      (e) => e.toString().split('.').last == databaseValue,
      orElse: () => throw ArgumentError('Invalid enum value: $databaseValue'),
    );
  }
}
