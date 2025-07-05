class NoteModel {
  final String id; // Changed from docId to id to match Supabase convention
  final String userId;
  final String title;
  final String description;
  final DateTime
  dateTime; // Changed from String to DateTime for proper type handling

  NoteModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.dateTime,
  });

  // Convert Supabase data to Dart object
  factory NoteModel.fromMap(Map<String, dynamic> data) {
    return NoteModel(
      id: data['id']?.toString() ?? '', // Supabase uses 'id' as primary key
      userId:
          data['user_id']?.toString() ??
          '', // Supabase typically uses snake_case
      title: data['title']?.toString() ?? '',
      description: data['description']?.toString() ?? '',
      dateTime:
          DateTime.tryParse(data['date_time']?.toString() ?? '') ??
          DateTime.now(),
    );
  }

  // Convert Dart object to Supabase map
  Map<String, dynamic> toMap() {
    return {
      if (id.isNotEmpty) 'id': id,
      'user_id': userId, // Using snake_case for Supabase
      'title': title,
      'description': description,
      'date_time': dateTime.toIso8601String(), // Storing as ISO string
    };
  }

  // Optional: Add copyWith method for easier updates
  NoteModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    DateTime? dateTime,
  }) {
    return NoteModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
