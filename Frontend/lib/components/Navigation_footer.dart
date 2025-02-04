import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/Menu_header.dart';
import '../pages/Homepage.dart';
import '../pages/Premium.dart';
// import '../pages/Settings.dart';
import '../pages/Profile.dart';

final bottomNavIndexProvider = StateProvider((ref) => 0);

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    print("Whole Page Built!");
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: MenuHeader(), // Use the custom AppBar
        ),
        body: Consumer(
          builder: (context, ref, child) {
            print('Index Stack Built!');
            final currentIndex = ref.watch(bottomNavIndexProvider);
            return IndexedStack(
              index: currentIndex,
              children: const [
                Center(
                  child: HomePage(),
                ),
                Center(
                  child: SubscriptionPage(),
                ),
                // Center(
                //   child:SearchPage(),
                // ),
                Center(
                  child:UserProfileScreen(),
                )
              ],
            );
          },
        ),
        bottomNavigationBar: Consumer(
          builder: (context, ref, child) {
            print("Bottom Navigation Built!");
            final currentIndex = ref.watch(bottomNavIndexProvider);
            return NavigationBar(
              selectedIndex: currentIndex,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.workspace_premium), label: 'Premium'),
                // NavigationDestination(
                //     icon: Icon(Icons.settings), label: 'Settings'),
                NavigationDestination(
                    icon: Icon(Icons.account_box), label: 'Profile'),
              ],
              onDestinationSelected: (value) {
                ref
                    .read(bottomNavIndexProvider.notifier)
                    .update((state) => value);
              },
            );
          },
        ));
  }
}
