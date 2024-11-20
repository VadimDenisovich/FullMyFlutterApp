class WordCard {
  final String first;
  final String second;
  final int id;

  WordCard({required this.id, required this.first, required this.second});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first': first,
      'second': second,
    };
  }

  factory WordCard.fromMap(Map<String, dynamic> map) {
    return WordCard(id: map['id'], first: map['first'], second: map['second']);
  }
}
