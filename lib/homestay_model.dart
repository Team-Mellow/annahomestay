class HomestayModel {
  final String houseName;

  HomestayModel({required this.houseName});

  factory HomestayModel.fromMap(Map<String, dynamic> map) {
    return HomestayModel(
      houseName: map['HouseName'] ?? '',
    );
  }
}
