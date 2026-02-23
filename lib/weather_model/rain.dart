class Rain {
  final double threeHour;

  Rain({required this.threeHour});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      threeHour: (json['3h'] as num).toDouble(),
    );
  }
}
