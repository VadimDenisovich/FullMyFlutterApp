import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj/screens/t_blocs/t_bloc.dart';
import 'package:flutter_proj/screens/test_screen.dart';
import 'services/card_database.dart';
import 'screens/add_word_screen.dart';
import 'screens/list_words_screen.dart';
import 'screens/test_screen.dart';
import 'screens/t_bloc_screen.dart';
import 'screens/t_blocs/t_bloc_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  /// Связка системы виджетов с ОС
  WidgetsFlutterBinding.ensureInitialized();

  /// Обращаемся к базе данных с карточками, которая сама себя инициализирует
  /// внутри класса
  await CardDatabase.instance.database;
  runApp(

      /// MultiBlocProvider позволяет получать в себя несколько BlocProvider или
      /// Cubit
      /// Каждый BlocProvider внутри создает и отправляет соответствующий BloC
      /// ниже по дереву виджетов
      /// Перестроение виджетов, где установлен Bloc происходит благодаря тому,
      /// что BlocBuilder подписывается на изменения состояния Bloc
      MultiBlocProvider(providers: [
    BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
    ),
  ], child: Start()));
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Full My App',

        /// Отключаем плашку дебаг на экране эмулятора
        debugShowCheckedModeBanner: false,
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
      case 2:
        page = TestScreen(); // Тестовый экран для добавления нового функционала
      case 3:
        page = TBlocScreen();
      default:
        throw UnimplementedError('page at $_selectedIndex doesn`t exist');
    }

    /// constraints - объект типа BoxConstraints
    /// содержит информацию о доступных размерах для дочерних виджетов
    ///
    /// Что содержит BoxConstraits:
    /// constraints.maxWidth: Максимальная доступная ширина.
    /// constraints.minWidth: Минимальная доступная ширина.
    /// constraints.maxHeight: Максимальная доступная высота.
    /// constraints.minHeight: Минимальная доступная высота.
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          body: Row(
        children: [
          SafeArea(
            /// NavigationRail - навигационная панель сбоку экрана
            /// Полезен для адаптивных приложений, поскольку способен сам
            /// ужиматься и расширяться
            /// @selectedIndex - индекс выбранного элемента
            /// @onDestinationSelected - колбэк, срабатываемый при выборе
            /// какого-то элемента навигации.
            /// @destinations - список элементов NavigationRailDestination
            /// @extended - булевое значени, указывающее должна ли панель быть
            /// расширенной (показывать текстовые названия иконок)
            child: NavigationRail(
              extended: constraints.maxWidth > 600,
              selectedIndex: _selectedIndex,
              destinations: [
                NavigationRailDestination(
                    icon: Icon(Icons.add), label: Text('Add word')),
                NavigationRailDestination(
                    icon: Icon(Icons.list), label: Text('List words')),
                NavigationRailDestination(
                    icon: Icon(Icons.text_decrease),
                    label: Text('Test screen')),
                NavigationRailDestination(
                    icon: Icon(Icons.block), label: Text('Bloc screen'))
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
