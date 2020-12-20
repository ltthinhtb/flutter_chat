class BillingAddress {
  int key;
  String firstName;
  String lastName;
  String fullName;
  String phoneNumber;
  String email;
  String address;
  String address1;
  String address2;
  String type;
  String city;
  String ward;
  String zip;
  String district;
  String country;

  BillingAddress(
      {this.key,
      this.address,
      this.firstName,
      this.lastName,
      this.fullName,
      this.phoneNumber,
      this.email,
      this.address1,
      this.address2,
      this.type,
      this.city,
      this.ward,
      this.zip,
      this.district,
      this.country});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    address1 = json['address_1'];
    this.firstName = json['first_name'];
    this.lastName = json['last_name'];
    this.address = json['address'];
    this.fullName = json['full_name'];
    this.phoneNumber = json['phone_number'];
    this.email = json['email'];
    this.address1 = json['address_1'];
    this.address2 = json['address_2'];
    this.type = json['type'];
    this.city = json['city'];
    this.ward = json['ward'];
    this.zip = json['zip'];
    this.district = json['district'];
    this.country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (key != null) data['key'] = this.key;
    if (firstName != null) data['first_name'] = this.firstName;
    if (lastName != null) data['last_name'] = this.lastName;
    if (fullName != null) data['full_name'] = this.fullName;
    if (phoneNumber != null) data['phone_number'] = this.phoneNumber;
    if (address != null) data['address'] = this.address;
    if (email != null) data['email'] = this.email;
    if (address1 != null) data['address_1'] = this.address1;
    if (address2 != null) data['address_2'] = this.address2;
    if (type != null) data['type'] = this.type;
    if (city != null) data['city'] = this.city;
    if (ward != null) data['ward'] = this.ward;
    if (zip != null) data['zip'] = this.zip;
    if (district != null) data['district'] = this.district;
    if (country != null) data['country'] = this.country;
    return data;
  }

  @override
  String toString() {
    return 'BillingAddress{firstName: $firstName, lastName: $lastName, fullName: $fullName, phoneNumber: $phoneNumber, email: $email, address1: $address1, address2: $address2, type: $type, city: $city, ward: $ward, zip: $zip, district: $district, country: $country}';
  }
}
