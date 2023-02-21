import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/model/category/transaction_model.dart';
import 'package:mymoney/screens/home/menu_bar.dart';
import 'package:mymoney/screens/widgets/notification_class.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PaymentModeAdapter().typeId)) {
    Hive.registerAdapter(PaymentModeAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    NotificationServices().notificationDetails();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuBarBottom(),
      initialRoute: '/',
      // routes: {
      //   '/': (context) => HomePage(),
      //   '/addscreen': (context) => AddScreen(),
      //   '/profilescreen': (context) => Profile()
      // },
    );
  }
}
