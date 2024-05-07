import 'package:flutter/material.dart';
import 'package:prayers_verses/my_futurebuilder.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  
  // final myDatabase = await $FloorMySectionDatabase.databaseBuilder('my_section_database.db').build();
  
  // runApp( MyVersesApp(myDatabase: myDatabase,));

  runApp( const MyVersesApp());
}

class MyVersesApp extends StatelessWidget {
  
  const MyVersesApp({super.key});
  
    
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyFutureBuilder();
  }
}

