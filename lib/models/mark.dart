class Mark {
  final String paperID;
  final double score;

  Mark({
    required this.paperID,
    required this.score,
  });

  factory Mark.fromJson(Map<String, dynamic> json) {
    return Mark(
      paperID: json['LessonID'].toString(),
      score: json['Score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'LessonID': paperID,
      'Score': score,
    };
  }
}
