import 't_bloc.dart';
import 'package:bloc/bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  // Конструктор CounterBloc вызывает конструктор родительского
  // класса Bloc, устанавливая начальное значение СounterState(10)
  CounterBloc() : super(CounterState(3)) {
    // Когда срабатывает IncrementEvent
    on<IncrementEvent>((event, emit) {
      emit(CounterState(state.counter + 1));
    });
    // Когда срабытывает DecrementEvent
    on<DecrementEvent>((event, emit) {
      if (state.counter == 0) return;
      emit(CounterState(state.counter - 1));
    });
  }
}
