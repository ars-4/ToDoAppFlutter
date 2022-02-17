import 'dart:convert';

class Note {
  int id;
  String noteT;
  String noteB;
  Note({
    required this.id,
    required this.noteT,
    required this.noteB,
  });

  Note copyWith({
    int? id,
    String? noteT,
    String? noteB,
  }) {
    return Note(
      id: id ?? this.id,
      noteT: noteT ?? this.noteT,
      noteB: noteB ?? this.noteB,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': noteT,
      'body': noteB,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id']?.toInt() ?? 0,
      noteT: map['title'] ?? '',
      noteB: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() => 'Note(id: $id, noteT: $noteT, noteB: $noteB)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Note &&
      other.id == id &&
      other.noteT == noteT &&
      other.noteB == noteB;
  }

  @override
  int get hashCode => id.hashCode ^ noteT.hashCode ^ noteB.hashCode;
}
