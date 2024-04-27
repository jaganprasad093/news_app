import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/homescreencontroller.dart';
import 'package:flutter_application_1/view/homescreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MYapp());
}

class MYapp extends StatelessWidget {
  const MYapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => homescreencontroller(),
        )
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
