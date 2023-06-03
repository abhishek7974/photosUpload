import 'package:flutter/material.dart';
import 'package:photos_api/view_model/Home_model.dart';
import 'package:provider/provider.dart';

import 'view/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: MaterialApp(
        title: 'Upload App',
        home: HomePage(),
      ),
    );
  }
}

