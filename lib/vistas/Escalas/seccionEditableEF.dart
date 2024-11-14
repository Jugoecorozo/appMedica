import 'package:flutter/material.dart';

class EditableSection extends StatefulWidget {
  final String title;
  final String initialText;
  final void Function(String, String) updateScaleValue;

  const EditableSection({
    Key? key,
    required this.title,
    required this.initialText,
    required this.updateScaleValue,
  }) : super(key: key);

  @override
  _EditableSectionState createState() => _EditableSectionState();
}

class _EditableSectionState extends State<EditableSection> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _controller,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            widget.updateScaleValue(widget.title, value);
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}