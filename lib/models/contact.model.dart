class Contact {
  final String id;
  final String firstName;
  final String lastName;

  Contact({required this.id, required this.firstName, required this.lastName});

  Map toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
      };

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'];
}
