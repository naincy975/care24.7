import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/customer_search_state.dart';
import 'screens/customer_search_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CustomerSearchState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Care 24*7',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.purpleAccent)),
      home: const CustomerSearchScreen(),
    );
  }
}
