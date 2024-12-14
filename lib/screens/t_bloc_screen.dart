import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 't_blocs/t_bloc_impl.dart';
import 't_blocs/t_bloc.dart';

class TBlocScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // BlocBuilder слушает изменения CounterBloc. Когда меняется его
          // состояния, то вызывается ф-ция builder и виджет перестраивается
          BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
            return Text('Sum: ${state.counter}');
          }),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                // Позволяет получить экземпляр класса CounterBloc из контекста
                // а затем добавляется к нему событие IncrementEvent
                // Событие принимается, и возвращается новое состояние
                //
                // 1. Пользователь нажимает кнопку.
                // 2. Вызывается context.read<CounterBloc>().add(IncrementEvent()).
                // 3. CounterBloc получает событие IncrementEvent и увеличивает
                // счетчик, эмитируя новое состояние CounterState.
                // 4. BlocBuilder обнаруживает изменение состояния и
                // вызывает функцию builder.
                // 5. Виджет, отображающий Sum: ${state.counter}, обновляется
                // с новым значением счетчика
                context.read<CounterBloc>().add(IncrementEvent());
              },
              child: Icon(Icons.add)),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                context.read<CounterBloc>().add(DecrementEvent());
              },
              child: Icon(Icons.remove))
        ],
      ),
    );
  }
}
