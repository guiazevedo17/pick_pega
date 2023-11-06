class Address {
  String? zip;
  String? number;
  String? uf;
  String? city;
  String? street;
  String? neighborhood;

  Address({
    this.zip,
    this.number,
    this.uf,
    this.city,
    this.street,
    this.neighborhood,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      zip: json['zip'],
      number: json['number'],
      uf: json['uf'],
      city: json['city'],
      street: json['street'],
      neighborhood: json['neighborhood'],
    );
  }
}
