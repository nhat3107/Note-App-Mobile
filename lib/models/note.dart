class Note {
  final int? id;       // id from SQLite (null for new note)
  final String title;
  final String body;

  Note({this.id, required this.title, required this.body});

  // For SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  // For API
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }
}
