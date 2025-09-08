import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const HomeScreen({super.key, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    if (!_initialized) {
      final provider = Provider.of<NoteProvider>(context, listen: false);
      provider.fetchApiNotes();
      provider.loadLocalNotes();
      _initialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await noteProvider.fetchApiNotes();
          await noteProvider.loadLocalNotes();
        },
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Text('📡 API Notes', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...noteProvider.apiNotes.map((n) => NoteCard(note: n)).toList(),
            const SizedBox(height: 16),
            Text(
              '💾 Local Notes (SQLite)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...noteProvider.localNotes.map((n) => NoteCard(note: n)).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
