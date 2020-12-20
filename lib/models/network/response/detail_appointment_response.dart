import 'package:vn_dental/models/network/response/list_case_response.dart';

class DetailAppointmentResponse {
  DetailAppointment data;

  DetailAppointmentResponse({this.data});

  DetailAppointmentResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new DetailAppointment.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DetailAppointment {
  String id;
  String treatment;
  String treatmentCost;
  String doctorName;
  String status;
  String doctorImg;
  String doctorSkill;
  String content;
  String timeStart;
  String timeEnd;
  String clinics;
  CaseData caseData;

  DetailAppointment(
      {this.id,
      this.treatment,
      this.treatmentCost,
      this.doctorName,
      this.status,
      this.doctorImg,
      this.doctorSkill,
      this.content,
      this.timeStart,
      this.timeEnd,
      this.clinics,
      this.caseData});

  DetailAppointment.fromJson(Map<String, dynamic> json) {
    doctorName = json['doctor_name'];
    status = json['status'];
    doctorImg = json['doctor_img'];
    content = json['content'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_name'] = this.doctorName;
    data['status'] = this.status;
    data['doctor_img'] = this.doctorImg;
    data['content'] = this.content;
    data['time_start'] = this.timeStart;
    data['time_end'] = this.timeEnd;
    return data;
  }
}
