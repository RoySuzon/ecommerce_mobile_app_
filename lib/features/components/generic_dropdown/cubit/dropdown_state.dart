// dropdown_state.dart
import 'package:equatable/equatable.dart';

abstract class DropdownState<T> extends Equatable {
  const DropdownState();
  @override
  List<Object?> get props => [];
}

class DropdownInitial<T> extends DropdownState<T> {}

class DropdownLoading<T> extends DropdownState<T> {}

class DropdownLoaded<T> extends DropdownState<T> {
  final List<T> items;
  final T? selectedItem;

  const DropdownLoaded({required this.items, this.selectedItem});

  @override
  List<Object?> get props => [items, selectedItem];
}

class DropdownError<T> extends DropdownState<T> {
  final String message;
  const DropdownError(this.message);

  @override
  List<Object?> get props => [message];
}
