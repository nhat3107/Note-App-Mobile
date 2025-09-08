import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  void _saveNote() async {
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) return;
    await Provider.of<NoteProvider>(context, listen: false)
        .addLocalNote(_titleController.text, _bodyController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveNote,
              icon: const Icon(Icons.save),
              label: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
