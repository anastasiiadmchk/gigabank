class Address {
  String? street;
  String? city;
  String? zipCode;
  String? country;
  Address({this.street, this.city, this.zipCode, this.country});
  @override
  String toString() {
    return '$street, $city, $zipCode, $country';
  }
}
