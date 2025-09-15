import 'package:ecommerce_app/features/components/generic_dropdown/cubit/dropdown_bloc.dart';
import 'package:ecommerce_app/features/components/generic_dropdown/cubit/dropdown_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropdown<T> extends FormField<T> {
  CustomDropdown({
    required this.bloc,
    required this.hintText,
    required this.itemToString,
    this.title,
    this.needExpanded = false,
    this.img,
    super.validator,
    super.onSaved,
    super.initialValue,
    super.key,
  }) : super(
         builder: (FormFieldState<T> field) {
           final state = field as _CustomDropdownState<T>;
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               if (title != null)
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 8),
                   child: Text(
                     title,
                     style: Theme.of(field.context).textTheme.titleMedium,
                   ),
                 ),
               GestureDetector(
                 onTap: state._toggleDropdown,
                 child: BlocBuilder<DropdownBloc<T>, DropdownState<T>>(
                   bloc: bloc,
                   builder: (context, blocState) {
                     var text = hintText;
                     if (blocState is DropdownLoaded<T> &&
                         blocState.selectedItem != null) {
                       text = itemToString(blocState.selectedItem as T);
                     }

                     return Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           padding: const EdgeInsets.symmetric(
                             horizontal: 12,
                             vertical: 14,
                           ),
                           decoration: BoxDecoration(
                             border: Border.all(
                               color: field.hasError
                                   ? Colors.red
                                   : Colors.grey.shade400,
                             ),
                             borderRadius: BorderRadius.circular(8),
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               if (needExpanded)
                                 Expanded(
                                   child: Text(
                                     text,
                                     maxLines: 1,
                                     overflow: TextOverflow.ellipsis,
                                     style: const TextStyle(fontSize: 16),
                                   ),
                                 )
                               else
                                 Text(
                                   text,
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                   style: const TextStyle(fontSize: 16),
                                 ),
                               const SizedBox(width: 4),
                               Icon(
                                 state._isOpen
                                     ? Icons.keyboard_arrow_up
                                     : Icons.keyboard_arrow_down,
                                 size: 24,
                               ),
                             ],
                           ),
                         ),
                         if (field.hasError)
                           Padding(
                             padding: const EdgeInsets.only(top: 4, left: 4),
                             child: Text(
                               field.errorText!,
                               style: const TextStyle(
                                 color: Colors.red,
                                 fontSize: 12,
                               ),
                             ),
                           ),
                       ],
                     );
                   },
                 ),
               ),
             ],
           );
         },
       );
  final DropdownBloc<T> bloc;
  final String? title;
  final String hintText;
  final String Function(T) itemToString;
  final String Function(T)? img;
  final bool needExpanded;

  @override
  FormFieldState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends FormFieldState<T> {
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _overlayEntry = _createOverlay();
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() => _isOpen = !_isOpen);
  }

  OverlayEntry _createOverlay() {
    final renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final widget = this.widget as CustomDropdown<T>;

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: BlocBuilder<DropdownBloc<T>, DropdownState<T>>(
            bloc: widget.bloc,
            builder: (context, state) {
              if (state is DropdownLoaded<T>) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return InkWell(
                        onTap: () {
                          widget.bloc.selectItem(item);
                          setValue(item); // ✅ update FormField value
                          _toggleDropdown();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Row(
                            children: [
                              if (widget.img != null) ...[
                                Image.network(
                                  widget.img!(item),
                                  height: 25,
                                  width: 40,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 8),
                              ],
                              Expanded(
                                child: Text(
                                  widget.itemToString(item),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, _) => const Divider(),
                  ),
                );
              } else if (state is DropdownLoading<T>) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is DropdownError<T>) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Error: ${state.message}'),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }
}
