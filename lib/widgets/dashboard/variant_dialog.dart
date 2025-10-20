// variant_dialog.dart
import 'package:flutter/material.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/variant_bloc/variant_state.dart';

class VariantDialog extends StatefulWidget {
  final VariantModel? existingVariant;
  final int? variantIndex;

  const VariantDialog({
    Key? key,
    this.existingVariant,
    this.variantIndex,
  }) : super(key: key);

  @override
  State<VariantDialog> createState() => _VariantDialogState();
}

class _VariantDialogState extends State<VariantDialog> {
  final TextEditingController _optionNameController = TextEditingController();
  final List<TextEditingController> _valueControllers = [];
  final List<FocusNode> _valueFocusNodes = [];

  @override
  void initState() {
    super.initState();
    
    if (widget.existingVariant != null) {
      _optionNameController.text = widget.existingVariant!.optionName;
      
      for (var value in widget.existingVariant!.values) {
        _addValueField(initialValue: value);
      }
    } else {
      _addValueField(); // Add first field by default
    }
  }

  @override
  void dispose() {
    _optionNameController.dispose();
    for (var controller in _valueControllers) {
      controller.dispose();
    }
    for (var node in _valueFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _addValueField({String? initialValue}) {
    setState(() {
      final controller = TextEditingController(text: initialValue ?? '');
      _valueControllers.add(controller);
      _valueFocusNodes.add(FocusNode());
    });
  }

  void _removeValueField(int index) {
    if (_valueControllers.length > 1) {
      setState(() {
        _valueControllers[index].dispose();
        _valueFocusNodes[index].dispose();
        _valueControllers.removeAt(index);
        _valueFocusNodes.removeAt(index);
      });
    }
  }

  void _handleSubmit(BuildContext context) {
    final optionName = _optionNameController.text.trim();
    final values = _valueControllers
        .map((c) => c.text.trim())
        .where((v) => v.isNotEmpty)
        .toList();

    if (optionName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter option name')),
      );
      return;
    }

    if (values.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one value')),
      );
      return;
    }

    Navigator.of(context).pop({
      'optionName': optionName,
      'values': values,
      'index': widget.variantIndex,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Option Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Option Name Field
            TextField(
              controller: _optionNameController,
              decoration: InputDecoration(
                hintText: 'Add Name',
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Option Values Label
            Text(
              'Option Values',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // Dynamic Value Fields
            ...List.generate(_valueControllers.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _valueControllers[index],
                        focusNode: _valueFocusNodes[index],
                        decoration: InputDecoration(
                          hintText: 'Add Value',
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        onChanged: (value) {
                          // Auto-add new field when typing in last field
                          if (index == _valueControllers.length - 1 &&
                              value.isNotEmpty) {
                            _addValueField();
                          }
                        },
                      ),
                    ),
                    if (_valueControllers.length > 1)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: GestureDetector(
                          onTap: () => _removeValueField(index),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),

            // Add Value Button
            GestureDetector(
              onTap: _addValueField,
              child: Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Center(
                  child: Text(
                    'Add Value',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Center(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _handleSubmit(context),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}