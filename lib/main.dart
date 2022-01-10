import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_store/constant/routes.dart';
import 'package:sample_store/notifier/store_notifier.dart';
import 'package:sample_store/ui/home/home_screen.dart';
import 'package:sample_store/ui/lanuch/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => StoreNotifier(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        routes: {
          MyRoutes.splashRoute: (context) => const SplashScreen(),
          MyRoutes.homeRoute: (context) => const HomeScreen(),
          MyRoutes.homeRoute: (context) => const HomeScreen(),
        });
  }
}
