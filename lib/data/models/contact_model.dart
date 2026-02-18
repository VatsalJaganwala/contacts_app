class ContactModel {
  final int? id;
  final String name;
  final String phone;
  final String email;
  final String? company;
  final String? notes;
  final bool isFavorite;
  final String createdAt;

  ContactModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.company,
    this.notes,
    this.isFavorite = false,
    required this.createdAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      company: map['company'],
      notes: map['notes'],
      isFavorite: map['isFavorite'] == 1,
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'company': company,
      'notes': notes,
      'isFavorite': isFavorite ? 1 : 0,
      'createdAt': createdAt,
    };
  }

  ContactModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? company,
    String? notes,
    bool? isFavorite,
    String? createdAt,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      company: company ?? this.company,
      notes: notes ?? this.notes,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
