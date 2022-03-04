class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String? mainAddress;

  Contact({required this.id, required this.firstName, required this.lastName, this.mainAddress});

  Map toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'mainAddress': mainAddress,
      };

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        mainAddress = json['mainAddress'];
}
