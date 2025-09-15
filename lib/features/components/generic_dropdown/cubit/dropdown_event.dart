// dropdown_event.dart
import 'package:equatable/equatable.dart';

abstract class DropdownEvent<T> extends Equatable {
  const DropdownEvent();
  @override
  List<Object?> get props => [];
}

class DropdownFetch<T> extends DropdownEvent<T> {
  final Future<List<T>> Function() fetchData;

  const DropdownFetch(this.fetchData);

  @override
  List<Object?> get props => [fetchData];
}
