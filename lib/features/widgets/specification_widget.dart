// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Specification {
  final String key;
  String value;

  Specification({required this.key, this.value = ''});

  @override
  String toString() => 'Specification(key: $key, value: $value)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'value': value,
    };
  }

  factory Specification.fromMap(Map<String, dynamic> map) {
    return Specification(
      key: map['key'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Specification.fromJson(String source) =>
      Specification.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DynamicSpecifications extends StatefulWidget {
  final List<String> availableKeys; // OS, RAM, Storage, etc.

  final void Function(List<Specification> specifications)?
  onSpecificationsChanged;
  const DynamicSpecifications({
    required this.availableKeys,
    super.key,
    this.onSpecificationsChanged,
  });

  @override
  State<DynamicSpecifications> createState() => _DynamicSpecificationsState();
}

class _DynamicSpecificationsState extends State<DynamicSpecifications> {
  final List<Specification> _specifications = [];
  final Map<String, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  List<String> get _remainingKeys {
    return widget.availableKeys
        .where((k) => !_specifications.any((s) => s.key == k))
        .toList();
  }

  void _addSpecificationDialog() {
    String? selectedKey;
    final valueController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Specification'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Specification',
                    border: OutlineInputBorder(),
                  ),
                  items: _remainingKeys
                      .map(
                        (key) => DropdownMenuItem(
                          value: key,
                          child: Text(key),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    selectedKey = v;
                  },
                  validator: (v) => v == null ? 'Select key' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: valueController,
                  decoration: const InputDecoration(
                    labelText: 'Value',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedKey != null && valueController.text.isNotEmpty) {
                  setState(() {
                    _specifications.add(
                      Specification(
                        key: selectedKey!,
                        value: valueController.text,
                      ),
                    );
                    widget.onSpecificationsChanged?.call(_specifications);
                    _controllers[selectedKey!] = valueController;
                    widget.onSpecificationsChanged?.call(_specifications);
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Select key and enter value'),
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Specifications',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (_specifications.isEmpty)
          const Text('No specifications added yet.')
        else
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: Scrollbar(
              child: ReorderableListView.builder(
                shrinkWrap: true,
                itemCount: _specifications.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex -= 1;
                    final item = _specifications.removeAt(oldIndex);
                    _specifications.insert(newIndex, item);
                    widget.onSpecificationsChanged?.call(_specifications);
                  });
                },
                itemBuilder: (context, index) {
                  final spec = _specifications[index];
                  return Padding(
                    key: ValueKey(spec.key), // Required for ReorderableListView
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CupertinoTextField.borderless(
                            controller: TextEditingController(text: spec.key),
                            readOnly: true,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey6,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: CupertinoTextField.borderless(
                            controller: _controllers[spec.key],
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey6,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onChanged: (v) {
                              spec.value = v;
                              widget.onSpecificationsChanged?.call(
                                _specifications,
                              );
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _controllers.remove(spec.key);
                              _specifications.removeAt(index);
                              widget.onSpecificationsChanged?.call(
                                _specifications,
                              );
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.drag_handle), // visual drag handle
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: _remainingKeys.isEmpty
              ? () {
                  log(_specifications.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All available specifications added'),
                    ),
                  );
                }
              : _addSpecificationDialog,
          icon: const Icon(Icons.add),
          label: const Text('Add Specification'),
        ),
      ],
    );
  }

  List<Specification> getSpecifications() => _specifications;
}
