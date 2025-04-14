// import 'package:flutter/material.dart';
// import 'package:mobile_db/pages/home_page.dart';
// import 'package:mobile_db/services/database_service.dart';

// void main() async{
//   runApp(const MyApp());
// }

// Future<void> setup() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await DatabaseService.setup();
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: HomePage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mobile_db/pages/home_page.dart';
import 'package:mobile_db/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

