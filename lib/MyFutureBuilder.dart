import 'package:flutter/material.dart';
import 'package:prayers_verses/data/local/my_section_database.dart';
import 'package:prayers_verses/my_navigation_bar.dart';
import 'package:prayers_verses/ui/my_section_provider.dart';

class MyFutureBuilder extends StatelessWidget {
  const MyFutureBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MySectionDatabase>(
      future: $FloorMySectionDatabase.databaseBuilder('my_section_database.db').build(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error initializing database: ${snapshot.error}'),
                ),
              ),
            );
          }
          final myDatabase = snapshot.data!;
          return MySectionProvider(
            myDatabase: myDatabase,
            child: MaterialApp(
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const MyNavigationBar(),
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

