import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'services/card_database.dart';
import 'screens/add_word_screen.dart';
import 'screens/list_words_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CardDatabase.instance.database;
  runApp(Start());
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Full My App',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(255, 0, 170, 255),
                dynamicSchemeVariant: DynamicSchemeVariant.fidelity)),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final textFont = TextStyle(fontSize: 36);

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = AddWord();
      case 1:
        page = ListWords();
      // Container(child: Text('page at $_selectedIndex', style: textFont));
      default:
        throw UnimplementedError('page at $_selectedIndex doesn`t exist');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: constraints.maxWidth > 600,
              selectedIndex: _selectedIndex,
              destinations: [
                NavigationRailDestination(
                    icon: Icon(Icons.add), label: Text('Add word')),
                NavigationRailDestination(
                    icon: Icon(Icons.list), label: Text('List words')),
              ],
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
          Expanded(
              child: Center(
            child: page,
          )),
        ],
      ));
    });
  }
}
