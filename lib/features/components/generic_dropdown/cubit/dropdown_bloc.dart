// dropdown_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dropdown_event.dart';
import 'dropdown_state.dart';

class DropdownBloc<T> extends Bloc<DropdownEvent<T>, DropdownState<T>> {
  DropdownBloc() : super(DropdownInitial<T>()) {
    on<DropdownFetch<T>>(_onFetch);
  }

  Future<void> _onFetch(
    DropdownFetch<T> event,
    Emitter<DropdownState<T>> emit,
  ) async {
    emit(DropdownLoading<T>());
    try {
      final items = await event.fetchData();
      emit(DropdownLoaded<T>(items: items));
    } catch (e) {
      emit(DropdownError<T>(e.toString()));
    }
  }

  void selectItem(T item) {
    final state = this.state;
    if (state is DropdownLoaded<T>) {
      emit(
        DropdownLoaded<T>(
          items: state.items,
          selectedItem: item,
        ),
      );
    }
  }
}
