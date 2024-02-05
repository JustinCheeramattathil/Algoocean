import 'package:dog_data/controller/bottomnavigation_provider.dart';
import 'package:dog_data/screens/cart/cart_page.dart';
import 'package:dog_data/screens/home/history_screen.dart';
import 'package:dog_data/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavigationProvider>(
        builder: (context, provider, _) {
          return IndexedStack(
            index: provider.currentIndex,
            children: [const HomeScreen(), HistoryScreen(), const CartPage()],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.watch<BottomNavigationProvider>().currentIndex,
          onTap: (newIndex) {
            context.read<BottomNavigationProvider>().changeIndex(newIndex);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: Colors.black,
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              label: 'Cart',
            ),
          ]),
    );
  }
}
