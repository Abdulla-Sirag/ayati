import 'package:flutter/material.dart';
import 'package:prayers_verses/data/local/my_section_dao.dart';
import 'package:prayers_verses/data/local/my_section_database.dart';
import 'package:prayers_verses/data/my_section_repository.dart';
import 'package:prayers_verses/ui/my_section_viewmodel.dart';
import 'package:provider/provider.dart';

class MySectionProvider extends StatelessWidget {
  final Widget child;

  final MySectionDatabase myDatabase;
   const MySectionProvider({super.key, required this.child, required this.myDatabase});

  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MySectionDatabase>(
          create: (_) => myDatabase,
          dispose: (_, db) => db.close(),
        ),
        ProxyProvider<MySectionDatabase, MySectionDao>(
          update: (_, database, __) => database.mySectionDao,
        ),
        ChangeNotifierProxyProvider<MySectionDao, MySectionViewModel>(
          create: (_) => MySectionViewModel(MySectionRepository(myDatabase)),
          update: (_, dao, viewModel) => viewModel!..updateRepository(MySectionRepository(myDatabase)),
        ),
      ],
      child: child,
    );  }
}
