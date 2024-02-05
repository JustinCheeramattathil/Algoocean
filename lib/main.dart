import 'package:dio/dio.dart';
import 'package:dog_data/controller/api_provider.dart';
import 'package:dog_data/controller/bottomnavigation_provider.dart';
import 'package:dog_data/screens/cart/cart_page.dart';
import 'package:dog_data/screens/root_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'model/dog_model.dart';

void main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(DogAdapter().typeId)) {
    Hive.registerAdapter(DogAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ApiProvider(Dio()),
        ),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dogs App',
        home: const RootPage(),
        routes: {
          '/cart':(context) => const CartPage()
        },
      ),
    );
  }
}
