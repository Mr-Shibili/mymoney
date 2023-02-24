import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/db/categorydb/transactiondb/transactiondb.dart';
import 'package:mymoney/screens/add_screen.dart';
import 'package:mymoney/screens/history.dart';
import 'package:mymoney/screens/home/home_page.dart';
import 'package:mymoney/screens/profile.dart';
import 'package:mymoney/screens/statitics.dart';
import 'package:mymoney/screens/widgets/notification_class.dart';

class MenuBarBottom extends StatefulWidget {
  const MenuBarBottom({super.key});

  @override
  State<MenuBarBottom> createState() => _MenuBarBottomState();
}

class _MenuBarBottomState extends State<MenuBarBottom> {
  int selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const History(),
    const AddScreen(),
    const Statitics(),
    const Profile(),
  ];
  @override
  void initState() {
    // TODO: implement initState

    Transactiondb.instance.refresh();
    CategoryDb.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions[selectedIndex],
        bottomNavigationBar: CustomNavigationBar(
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: (index) async {
              setState(() {
                selectedIndex = index;
              });
              await CategoryDb.instance.refreshUI();
            },
            items: [
              CustomNavigationBarItem(
                  icon: const Icon(
                Iconsax.element_3,
              )),
              CustomNavigationBarItem(
                icon: const Icon(
                  Iconsax.document,
                ),
              ),
              CustomNavigationBarItem(
                icon: const Icon(
                  Iconsax.add_square,
                  size: 30,
                ),
              ),
              CustomNavigationBarItem(
                icon: const Icon(
                  Iconsax.status_up,
                ),
              ),
              CustomNavigationBarItem(
                icon: const Icon(
                  Iconsax.profile_circle,
                ),
              ),
            ]));
  }
}
