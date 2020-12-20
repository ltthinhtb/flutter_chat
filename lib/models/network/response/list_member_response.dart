import 'package:vn_dental/models/network/response/billing_address.dart';

class ListMemberResponse {
  List<MemberData> data;

  ListMemberResponse({this.data});

  ListMemberResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MemberData>();
      json['data'].forEach((v) {
        data.add(new MemberData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MemberData {
  int id;
  String relationship;
  String name;
  String birthday;
  String phone;
  BillingAddress address;

  MemberData({this.id, this.relationship, this.name, this.birthday,this.phone,this.address});

  MemberData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    relationship = json['relationship'];
    name = json['name'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['relationship'] = this.relationship;
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    return data;
  }
}
