import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pmsn2024/screens/exit_screen.dart';
import 'package:pmsn2024/screens/profile_screen.dart';
import 'package:pmsn2024/settings/colors_settings.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/settings/theme_settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.navColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset('assets/logo.png'),
            ),
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (index) {
            case 1:
              return ProfileScreen();
            case 2:
              return ExitScreen();
            default:
              return Container();
          }
        },
      ),

      //endDrawer: Drawer(),
      drawer: myDrawer(),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.exit_to_app, title: 'Exit'),

        ],
        onTap: (int i) => setState(() {
          index = i;
        }),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        children: [
          FloatingActionButton.small(
            heroTag: 'btn1',
              onPressed: () {
               GlobalValues.themeMode.value = 0;
                ThemeSettings.lightTheme();
              }, child: Icon(Icons.light_mode)),

          FloatingActionButton.small(
            heroTag: 'btn2',
              onPressed: () {
               GlobalValues.themeMode.value = 1;
              ThemeSettings.darkTheme();
              }, child: Icon(Icons.dark_mode)),

              FloatingActionButton.small(
            heroTag: 'btn3',
              onPressed: () {
               GlobalValues.themeMode.value = 2;
              ThemeSettings.customTheme();
              }, child: Icon(Icons.settings)),
        ],
      ),
    );
  }

  Widget myDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/d/d1/Mencho_-_2018_Wanted_Poster_%28cropped%29_%28cropped%29.PNG'),
            ),
            accountName: Text('Nemesio Ruben Oseguera Cervantes'),
            accountEmail: Text('mencho@itcelaya.edu.mx'),
          ),
          ListTile(
          //onTap: () => Navigator.pushNamed(context, '/db'),
            onTap: () => Navigator.of(context).pushNamed('/db'),
            title: const Text('Movies LIST'),
            subtitle: const Text('Lorem ipsum dolor sit amet'),
            leading: const Icon(Icons.movie),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            title: const Text('Configuración de Tema'),
            leading: const Icon(Icons.color_lens),
            onTap: () {
              Navigator.pushNamed(context, '/theme');
            },
          ),
        ],
      ),
    );
  }
}
