class Clinic {
  int id;
  String name;
  String email;
  String phone;
  String avatar;
  String website;
  String fanpage;
  List<String> images;
  String description;
  List<Service> services;

  Clinic(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.avatar,
      this.website,
      this.fanpage,
      this.description,
      this.services,
      this.images});
}

class Service {
  int id;
  String name;

  Service({
    this.id,
    this.name,
  });
}
