import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../db/note_database.dart';
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _apiNotes = [];
  List<Note> _localNotes = [];
  String? _apiError;

  List<Note> get apiNotes => _apiNotes;
  List<Note> get localNotes => _localNotes;
  String? get apiError => _apiError;

  // Fetch notes from API
  Future<void> fetchApiNotes() async {
    try {
      _apiError = null;
      final url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_limit=5',
      );
      final response = await http.get(
        url,
        headers: const {
          'Accept': 'application/json',
          'User-Agent': 'demo02-app/1.0 (Flutter; dart:io)',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        _apiNotes = data.map((json) => Note.fromJson(json)).toList();
      } else {
        _apiNotes = [];
        _apiError =
            'HTTP ${response.statusCode}: ${response.reasonPhrase ?? ''}';
      }
      notifyListeners();
    } catch (e) {
      _apiNotes = [];
      _apiError = 'Network error: $e';
      notifyListeners();
    }
  }

  // Load local notes from SQLite
  Future<void> loadLocalNotes() async {
    _localNotes = await NoteDatabase.instance.readAllNotes();
    notifyListeners();
  }

  // Add new note to SQLite
  Future<void> addLocalNote(String title, String body) async {
    final newNote = Note(title: title, body: body);
    await NoteDatabase.instance.create(newNote);
    await loadLocalNotes();
  }
}
