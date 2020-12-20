class ListDoctorResponse {
  String status;
  String messages;
  List<DoctorData> data;

  ListDoctorResponse({this.status, this.messages, this.data});

  ListDoctorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    if (json['data'] != null) {
      data = new List<DoctorData>();
      json['data'].forEach((v) {
        data.add(new DoctorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorData {
  String doctorName;
  String doctorIntroduce;
  String doctorAvatar;
  int doctorId;
  String like;
  String expensive;
  String clinics;
  String phoneNumber;

  DoctorData(
      {this.doctorName,
      this.doctorIntroduce,
      this.doctorAvatar,
      this.doctorId,
      this.expensive,
      this.like,
      this.clinics,
      this.phoneNumber});

  DoctorData.fromJson(Map<String, dynamic> json) {
    doctorName = json['doctor_name'];
    doctorIntroduce = json['doctor_introduce'];
    doctorAvatar = json['doctor_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_name'] = this.doctorName;
    data['doctor_introduce'] = this.doctorIntroduce;
    data['doctor_avatar'] = this.doctorAvatar;
    return data;
  }
}
