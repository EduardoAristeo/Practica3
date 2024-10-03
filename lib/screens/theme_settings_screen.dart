import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2024/settings/global_values.dart';
import 'package:pmsn2024/settings/theme_preferences.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Tema'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: GlobalValues.themeMode,
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildThemeOption(
                  context: context,
                  themeValue: 0,
                  title: 'Tema Claro',
                  icon: CupertinoIcons.sun_max,
                  selected: value == 0,
                  onSelected: (newValue) {
                    _changeTheme(context, newValue);
                  },
                ),
                _buildThemeOption(
                  context: context,
                  themeValue: 1,
                  title: 'Tema Oscuro',
                  icon: CupertinoIcons.moon,
                  selected: value == 1,
                  onSelected: (newValue) {
                    _changeTheme(context, newValue);
                  },
                ),
                _buildThemeOption(
                  context: context,
                  themeValue: 2,
                  title: 'Tema Personalizado',
                  icon: CupertinoIcons.circle_grid_hex_fill,
                  selected: value == 2,
                  onSelected: (newValue) {
                    _changeTheme(context, newValue);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required BuildContext context,
    required int themeValue,
    required String title,
    required IconData icon,
    required bool selected,
    required Function(int) onSelected,
  }) {
    return Card(
      elevation: selected ? 4 : 1, // Elevación según si está seleccionada
      color: selected ? Theme.of(context).primaryColorLight : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () {
          onSelected(themeValue);
        },
        leading: Icon(
          icon,
          color: selected ? Theme.of(context).primaryColor : Colors.grey,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: selected ? Theme.of(context).primaryColor : Colors.black,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: selected
            ? Icon(CupertinoIcons.check_mark_circled, color: Theme.of(context).primaryColor)
            : null,
      ),
    );
  }

  void _changeTheme(BuildContext context, int newValue) async {
    GlobalValues.themeMode.value = newValue;
    await ThemePreference().setTheme(newValue);
  }
}
